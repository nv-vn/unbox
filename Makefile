CC := gcc
CFLAGS := -Wall -Wpedantic -std=c99

LD := ld
LFLAGS :=

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
LIBDIR ?= $(PREFIX)/lib
CONFDIR ?= ~/.config
PKGCONFIGDIR ?= $(LIBDIR)/pkgconfig

PKGCONFIG ?= pkg-config

DEPS := guile-2.0
SOURCES := src/unbox.c
OBJECTS := $(SOURCES:%.c=%.o)
TARGETS := unbox

CLEAN_FILES := $(TARGETS) $(OBJECTS)

PKG_CFLAGS ?= $(call pkgconfig,$(DEPS),cflags,CFLAGS)
PKG_LIBS ?= $(call pkgconfig,$(DEPS),libs,LIBS)

link        = $(CC) $(LFLAGS) -o $@ $^
pkgconfig   = $(foreach pkg,$(1),$(if $($(pkg)_$(3)),$($(pkg)_$(3)), \
                                      $(shell $(PKGCONFIG) --$(2) $(pkg))))

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $^ $(PKG_CFLAGS)

unbox: $(OBJECTS)
	$(link) $(PKG_LIBS) -lm

install: $(TARGETS)
	install -m 755 unbox $(DESTDIR)$(BINDIR)

install-user:
	mkdir -p $(CONFDIR)/unbox
	install -m 755 ob-sexpr.scm $(CONFDIR)/unbox
	install -m 755 rc.scm $(CONFDIR)/unbox

clean:
	rm -rf $(CLEAN_FILES)
