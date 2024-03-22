#!/bin/sh

q="$1"
test -n "$q" || exit 1

pkg=$(dlocate -F "$q" | head -1 | cut -d: -f1)
re='^..\s'$pkg'\s'
COLUMNS=160 dlocate -P "$re" -l | tail -1 |
  awk '{ print $2"_"$3 }'
test -n "$pkg" || echo "Unknown"
