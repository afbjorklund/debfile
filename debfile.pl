#!/usr/bin/perl

use strict;
use GDBM_File;

my $database='/var/cache/debfile.db';
my $q = $ARGV[0];

my %dbm;
tie %dbm, 'GDBM_File', $database, GDBM_READER, 0444
    or die "$GDBM_File::gdbm_errno";
my $pkg = $dbm{$q};
print "$dbm{$pkg}\n" if $pkg;
untie %dbm;
exit 1 unless $pkg;
