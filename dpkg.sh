#!/bin/sh

q="$1"
test -n "$q" || exit 1

pkg=$(dpkg -S "$q" 2>/dev/null | cut -d: -f1)
# shellcheck disable=SC2016
qf='${Package}_${Version}:${Architecture}\n'
dpkg-query -f "$qf" -W "$pkg" 2>/dev/null
