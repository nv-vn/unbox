#include <pwd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <libguile.h>

#define UNBOX_VERSION "1.0"

static char *get_home() {
  char *homedir;
  if ((homedir = getenv("HOME")) == NULL) {
    homedir = getpwuid(getuid())->pw_dir;
  }
  return homedir;
}

static char *get_in_home(char *path) {
  char *home;
  home = get_home();

  char *final = malloc(strlen(home) + strlen(path) + 1);
  strcpy(final, home);
  strcat(final, path);

  return final;
}

int main(int argc, char **argv) {
  char *out = get_in_home("/.config/unbox/rc.xml"), *in = get_in_home("/.config/unbox/rc.scm");
  bool format = false;
  for (int i = 1; i < argc; i++) {
    if (strcmp(argv[i], "-o") == 0 && i + 1 < argc) {
      out = argv[++i];
    } else if (strcmp(argv[i], "-f") == 0) {
      format = true;
    } else if (strcmp(argv[i], "-v") == 0) {
      printf("Using unbox version %s\n", UNBOX_VERSION);
      return EXIT_SUCCESS;
    } else if (strcmp(argv[i], "-h") == 0) {
      printf("Available options:\n");
      printf("\t-o <file name> -- Name of output file\n");
      printf("\t-f -- Format XML output\n");
      printf("\t-h -- Show list of available options\n");
      printf("\t-v -- Show version of unbox currently in use\n");
      printf("\t <file name> -- Name of input file\n");
      return EXIT_SUCCESS;
    } else {
      in = argv[i];
    }
  }

  scm_init_guile();
  scm_c_primitive_load(get_in_home("/.config/unbox/ob-sexpr.scm"));
  scm_c_primitive_load(in);

  SCM gen_rc, rc_string;
  gen_rc = scm_variable_ref(scm_c_lookup("gen-rc"));
  rc_string = scm_call_0(gen_rc);

/* How to do this with Guile 2.0 API?
  if (rc_string->type != string)
    return EXIT_FAILURE; */

  char *str = scm_to_locale_string(rc_string);

  FILE *f = fopen(out, "w");

  if (f == NULL) {
    printf("Could not open output file for writing\n");
    return EXIT_FAILURE;
  }

  fprintf(f, str);

  fclose(f);

  if (format == true) {
    // "xmllint --format " out " >" out ".tmp;mv " out ".tmp" out
    const int outlen = strlen(out);
    const int cmdlen = 17 + outlen + 2 + outlen + 8 + outlen + 4 + outlen;
    char cmd[cmdlen + 1]; // Leave room for \0
    sprintf(cmd, "xmllint --format %s >%s.tmp;mv %s.tmp %s", out, out, out, out);
    return system(cmd);
  }

  return EXIT_SUCCESS;
}
