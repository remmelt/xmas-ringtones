#!/usr/bin/env bash
set -euo pipefail

# Usage: wav2m4r.sh /path/to/input.wav
# Creates /path/to/input.m4r (mono summed) for iPhone ringtones.

in="${1:-}"
if [[ -z "${in}" ]]; then
  echo "Usage: $(basename "$0") /path/to/input.wav" >&2
  exit 2
fi
if [[ ! -f "$in" ]]; then
  echo "File not found: $in" >&2
  exit 2
fi

# Build output path: same dir, same basename, .m4r extension
dir="$(cd "$(dirname "$in")" && pwd)"
base="$(basename "$in")"
stem="${base%.*}"
out="out/${stem}.m4r"

# Ringtone constraints: <= 30s. Adjust DUR if you want.
DUR_SECONDS="8"

# Sum to mono (true L+R sum) and encode AAC in an .m4r container.
# - If input is already mono, the pan filter will keep it mono.
ffmpeg -hide_banner -y -i "$in" \
  -af "atrim=0:${DUR_SECONDS},asetpts=PTS-STARTPTS,pan=mono|c0=0.5*c0+0.5*c1" \
  -ar 44100 \
  -c:a aac -b:a 192k \
  -movflags +faststart \
  -f ipod \
  "$out"

echo "$out"

