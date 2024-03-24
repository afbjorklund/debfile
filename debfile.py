#!/usr/bin/python3

import sys
import dbm.gnu

database = "/var/cache/debfile.db"
query = sys.argv[1]

dbm = dbm.gnu.open(database, 'r', 0o444)
try:
    pkg = dbm[query].decode('ascii')
    print("%s_%s" % (pkg, dbm[pkg].decode('ascii')))
except KeyError:
    sys.exit(1)
