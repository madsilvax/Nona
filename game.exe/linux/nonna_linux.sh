#!/bin/sh
echo -ne '\033c\033]0;Nona\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/nonna_linux.x86_64" "$@"
