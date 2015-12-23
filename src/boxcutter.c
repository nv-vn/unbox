#include <pwd.h>
#include <stdio.h>
#include <stdlib.h>
#include <libguile.h>

char *get_home() {
  char *homedir;
  if ((homedir = getenv("HOME")) == NULL) {
    homedir = getpwuid(getuid())->pw_dir;
  }
  return homedir;
}

char *get_in_home(char *path) {
  char *home;
  home = get_home();

  char *final = malloc(strlen(home) + strlen(path) + 1);
  strcpy(final, home);
  strcat(final, path);

  return final;
}

int main(int argc, char **argv) {
  scm_init_guile();
  scm_c_primitive_load(get_in_home("/.config/boxcutter/ob-sexpr.scm"));
  scm_c_primitive_load(get_in_home("/.config/boxcutter/rc.scm"));

  SCM gen_rc, rc_string;
  gen_rc = scm_variable_ref(scm_c_lookup("gen-rc"));
  rc_string = scm_call_0(gen_rc);

/* How to do this with Guile 2.0 API?
  if (rc_string->type != string)
    return EXIT_FAILURE; */

  char *str = scm_to_locale_string(rc_string);

  FILE *f = fopen(get_in_home("/.config/boxcutter/rc.xml"), "w"); // Let's not write to the real file for now ...
  if (f == NULL)
    return EXIT_FAILURE;

  fprintf(f, str);

  fclose(f);

  return EXIT_SUCCESS;
}
