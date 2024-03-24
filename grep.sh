#!/bin/sh

q="$1"
test -n "$q" || exit 1

pkg=$(grep "^$q:" debfiledb | cut -d: -f2 | tr -d ' ')
grep "^$pkg:" debfiledb | sed -e "s/: /_/"
