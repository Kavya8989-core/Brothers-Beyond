#!/bin/sh
printf '\033c\033]0;%s\a' brothers beyond
base_path="$(dirname "$(realpath "$0")")"
"$base_path/brothers beyond.x86_64" "$@"
