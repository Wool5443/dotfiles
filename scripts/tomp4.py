#!/usr/bin/env python3

import subprocess
import sys
import os
import re
from concurrent.futures import ProcessPoolExecutor, as_completed
from tqdm import tqdm
from threading import Lock

# Precompile regex patterns
DURATION_REGEX = re.compile(r"Duration: (\d{2}):(\d{2}):(\d{2})\.\d{2}")
TIME_REGEX = re.compile(r"time=(\d{2}):(\d{2}):(\d{2})\.\d{2}")

# Global variables for progress tracking
progress_bars = {}
progress_lock = Lock()
tqdm_position = 0
tqdm_position_lock = Lock()


def get_tqdm_position():
    global tqdm_position
    with tqdm_position_lock:
        pos = tqdm_position
        tqdm_position += 1
    return pos


def parse_ffmpeg_progress(line, filename):
    # Parse duration
    duration_match = DURATION_REGEX.search(line)
    if duration_match:
        hours, minutes, seconds = map(int, duration_match.groups())
        total_seconds = hours * 3600 + minutes * 60 + seconds
        with progress_lock:
            if filename in progress_bars:
                progress_bars[filename]["total"] = total_seconds
                progress_bars[filename]["pbar"].reset(total=total_seconds)
        return total_seconds

    # Parse current time
    time_match = TIME_REGEX.search(line)
    if time_match:
        hours, minutes, seconds = map(int, time_match.groups())
        current_seconds = hours * 3600 + minutes * 60 + seconds
        with progress_lock:
            if filename in progress_bars:
                if progress_bars[filename]["total"] > 0:
                    progress_bars[filename]["pbar"].n = current_seconds
                    progress_bars[filename]["pbar"].refresh()


def convert_mkv_to_mp4(input_file, audio_index=0, subtitle_index=0, position=0):
    if not input_file.lower().endswith(".mkv"):
        return f"❌ Skipped (not MKV): {input_file}"

    base, _ = os.path.splitext(input_file)
    output_video = base + ".mp4"
    output_subs = base + ".srt"

    # Create progress bar with locked position
    with progress_lock:
        progress_bars[input_file] = {
            "pbar": tqdm(
                total=1,
                desc=os.path.basename(input_file)[:40].ljust(40),
                position=position,
                leave=False,
                unit="s",
                bar_format="{l_bar}{bar}| {n_fmt}/{total_fmt}s [{elapsed}<{remaining}]",
                dynamic_ncols=True,
            ),
            "total": 0,
        }

    try:
        ffmpeg_command = [
            "ffmpeg",
            "-i",
            input_file,
            "-map",
            "0:v:0",
            "-map",
            f"0:a:{audio_index}",
            "-map",
            f"0:s:{subtitle_index}",
            "-c:v",
            "copy",
            "-c:a",
            "aac",
            "-c:s",
            "mov_text",
            "-y",
            output_video,
        ]

        process = subprocess.Popen(
            ffmpeg_command, stderr=subprocess.PIPE, universal_newlines=True, bufsize=1
        )

        if process.stderr is None:
            raise RuntimeError("Failed to capture FFmpeg stderr output")

        while True:
            line = process.stderr.readline()
            if not line:
                if process.poll() is not None:
                    break
                continue
            parse_ffmpeg_progress(line, input_file)

        if process.returncode != 0:
            raise subprocess.CalledProcessError(process.returncode, ffmpeg_command)

        # Extract subtitles
        subprocess.run(
            [
                "ffmpeg",
                "-i",
                input_file,
                "-map",
                f"0:s:{subtitle_index}",
                output_subs,
                "-y",
                "-loglevel",
                "error",
            ],
            check=True,
        )

    except subprocess.CalledProcessError:
        with progress_lock:
            progress_bars[input_file]["pbar"].close()
            del progress_bars[input_file]
        return f"❌ Failed: {input_file}"
    except Exception as e:
        with progress_lock:
            progress_bars[input_file]["pbar"].close()
            del progress_bars[input_file]
        return f"❌ Error: {input_file} - {str(e)}"

    with progress_lock:
        progress_bars[input_file]["pbar"].close()
        tqdm.write(f"✅ Done: {input_file}")
        del progress_bars[input_file]

    return None


def main():
    if len(sys.argv) < 2:
        print("Provide mkv files")
        return

    try:
        print("Input preferred audio and subtitle tracks (space separated):")
        vid, sub = map(int, input().split())
        print("Input max concurrent jobs:")
        conc = int(input())
    except ValueError as e:
        print(f"Bad value: {e}")
        return

    input_files = sys.argv[1:]
    positions = [get_tqdm_position() for _ in input_files]

    # Initialize all progress bars first
    with progress_lock:
        for f, pos in zip(input_files, positions):
            progress_bars[f] = {
                "pbar": tqdm(
                    total=1,
                    desc=os.path.basename(f)[:40].ljust(40),
                    position=pos,
                    leave=False,
                    unit="s",
                    bar_format="{l_bar}{bar}| {n_fmt}/{total_fmt}s [{elapsed}<{remaining}]",
                    dynamic_ncols=True,
                ),
                "total": 0,
            }

    with ProcessPoolExecutor(max_workers=conc) as executor:
        futures = []
        for f, pos in zip(input_files, positions):
            futures.append(executor.submit(convert_mkv_to_mp4, f, vid, sub, pos))

        for future in as_completed(futures):
            result = future.result()
            if result:
                tqdm.write(result)


if __name__ == "__main__":
    main()
