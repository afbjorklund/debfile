#!/bin/sh

database="/var/cache/debfile.db"
query=$1

pkg=$(gdbmtool -r $database fetch "$query" 2>/dev/null)
test -n "$pkg" && printf "%s_%s\n" "$pkg" $(gdbmtool -r $database fetch "$pkg")
