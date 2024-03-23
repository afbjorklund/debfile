#include "debfile.h"
#include <gdbm.h>
#include <stdio.h>
#include <string.h>

int
main (int argc, char **argv)
{
  GDBM_FILE gdbf;
  datum path, package, version;
  int status = 0;

  if (argc != 2)
    {
      fprintf (stderr, "usage: %s PATH\n", argv[0]);
      return 2;
    }

  gdbf = gdbm_open (DBFILE, 0, GDBM_READER, 0, NULL);
  if (gdbf == NULL)
    {
      fprintf (stderr, "can't open database: %s\n",
               gdbm_strerror (gdbm_errno));
      return 3;
    }

  path.dptr = argv[1];
  path.dsize = strlen (argv[1]);

  package = gdbm_fetch (gdbf, path);
  if (gdbm_errno == GDBM_ITEM_NOT_FOUND)
    {
      status = 1;

      goto exit;
    }
  else if (package.dptr == NULL)
    {
      fprintf (stderr, "%s\n", gdbm_db_strerror (gdbf));
      status = 2;

      goto exit;
    }

  version = gdbm_fetch (gdbf, package);
  if (version.dptr != NULL)
    {
      fwrite (version.dptr, version.dsize, 1, stdout);
      putchar ('\n');
      status = 0;
    }
  else if (gdbm_errno == GDBM_ITEM_NOT_FOUND)
    {
      status = 1;
    }
  else
    {
      fprintf (stderr, "%s\n", gdbm_db_strerror (gdbf));
      status = 2;
    }

exit:

  gdbm_close (gdbf);
  return status;
}
