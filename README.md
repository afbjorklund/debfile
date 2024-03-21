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
