#!/usr/bin/env python3

import ffmpeg
import sys
import os
import subprocess

def convert_mkv_to_mp4(input_file, audio_index=0, subtitle_index=0):
    if not input_file.lower().endswith(".mkv"):
        print(f"Skipping unsupported file: {input_file}")
        return

    base, _ = os.path.splitext(input_file)
    output_video = base + ".mp4"
    output_subs = base + ".srt"

    print(f"🎞️  Converting: {input_file} → {output_video}")
    try:
        # Convert to MP4
        (
            ffmpeg
            .input(input_file)
            .output(
                output_video,
                **{
                    'map': ['0:v:0', f'0:a:{audio_index}', f'0:s:{subtitle_index}'],
                    'c:v': 'copy',
                    'c:a': 'aac',
                    'c:s': 'mov_text'
                }
            )
            .run(overwrite_output=True)
        )
        print(f"✅ MP4 done: {output_video}")
    except ffmpeg.Error as e:
        print("❌ ffmpeg error:", e.stderr.decode())

    print(f"📝 Extracting subtitles → {output_subs}")
    try:
        subprocess.run([
            "ffmpeg", "-i", input_file,
            "-map", f"0:s:{subtitle_index}",
            output_subs,
            "-y"
        ], check=True)
        print(f"✅ Subtitles extracted: {output_subs}")
    except subprocess.CalledProcessError as e:
        print("❌ Failed to extract subtitles")

def main():
    if len(sys.argv) < 2:
        print("Drag and drop MKV files onto this script.")
        return

    for input_path in sys.argv[1:]:
        convert_mkv_to_mp4(input_path)

if __name__ == "__main__":
    main()
