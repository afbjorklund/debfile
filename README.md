# debfile

Returns which `dpkg` package owns a particular file, and its version too.

Similar to `dpkg -S` and `dpkg-query -W`, but much faster (uses dlocate).

The deb equivalent of running `rpm -qf`.

Remember to run `sudo update-dlocatedb`.

## zstd

The default dlocatedb takes a lot of disk space, when not compressed...

But compressing it with gzip, makes dlocate run much slower (like 10x)

Use zstd instead, see: dlocate-zstd.diff

Still compresses 10x, but runs 10x faster

## grep

For reasons why dlocate is using text files and `grep`, instead of `locate`:

<https://jvns.ca/blog/2015/03/05/how-the-locate-command-works-and-lets-rewrite-it-in-one-minute/>

The debfile "database" maps from paths to packages, and packages to versions.

But since it doesn't use regular expressions, it can be converted into a dbm.

## text

For debugging purposes or other experiments, you can make it output text:

`DEBFILE_TEXT=1 ./convertdb.pl > debfiledb`

The format is actually YAML, and can be converted to e.g. JSON using `yq`.

Or one can use grep instead of gdbm, just like with the dlocate database.

## cron

The dlocatedb is normally updated from `/etc/cron.daily/dlocate`

You can update the debfile.db as well, from the same daily job.

Something like this: dlocate-debfile.diff

Or run `sudo /usr/share/dlocate/convertdb`.
