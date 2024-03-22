#!/usr/bin/python3

import sys
import dbm.gnu

database = "/var/cache/debfile.db"
query = sys.argv[1]

dbm = dbm.gnu.open(database, 'r', 0o444)
try:
    print(dbm[dbm[query]].decode("ascii"))
except KeyError:
    sys.exit(1)
