#!/usr/bin/env sh
# Plasma sources this before launching the desktop and applications.
export EDITOR=nvim
export VISUAL=nvim
export CC=gcc
export CXX=g++
export CMAKE_GENERATOR='Ninja Multi-Config'
export ELECTRON_OZONE_PLATFORM_HINT=auto
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
