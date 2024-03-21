#!/bin/sh

database="debfile.db"
query=$1

pkg=$(gdbmtool -r $database fetch "$query" 2>/dev/null)
test -n "$pkg" && gdbmtool -r $database fetch "$pkg"
