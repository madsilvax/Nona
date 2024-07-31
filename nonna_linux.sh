#!/bin/sh
echo -ne '\033c\033]0;Projeto Integrado III\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/nonna_linux.x86_64" "$@"
