#!/usr/bin/perl
# convertdb, convert dlocatedb to gnu dbm
# Copyright (C) 2024  Anders F Björklund

#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.

#   You should have received a copy of the GNU General Public License along
#   with this program; if not, write to the Free Software Foundation, Inc.,
#   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

use strict;
use GDBM_File;

my $dbfile='/var/lib/dlocate/dlocatedb';
my $dpkglist='/var/lib/dlocate/dpkg-list';
#my $database='debfile.db';
my $database='/var/cache/debfile.db';

my $cat = 'cat';
my $gzip = !system("gzip --list $dbfile >/dev/null 2>&1");
$cat = 'zcat' if $gzip;
my $zstd = !system("zstd --list $dbfile >/dev/null 2>&1");
$cat = 'zstdcat' if $zstd;

my %ver;
if (open(DPKGLIST,'<', $dpkglist)) {
    while (<DPKGLIST>) {
        chomp;
        next if (/^=$/);
        my ($st, $package,$version) = split /\s/;
	next unless ($st eq 'ii');
	$ver{$package} = "$version";
    };
    close(DPKGLIST);
};

my %pkg;
if (open(DLOCATEDB,"$cat $dbfile|")) {
    while (<DLOCATEDB>) {
        chomp;
        my ($package,$path) = split /: /;
	next if ($path eq '/.');
	$pkg{$path} = $package;
    };
    close(DLOCATEDB);
};

my %dbm;
tie %dbm, 'GDBM_File', $database, GDBM_WRCREAT, 0644
    or die "$GDBM_File::gdbm_errno";
for (sort keys %pkg){
	$dbm{$_} = $pkg{$_};
	print("$_: $pkg{$_}\n") if $ENV{'DEBFILE_TEXT'};
}
for (sort keys %ver){
	$dbm{$_} = $ver{$_};
	print("$_: $ver{$_}\n") if $ENV{'DEBFILE_TEXT'};
}
untie %dbm;
