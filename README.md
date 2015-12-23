# boxcutter
OpenBox rc.xml Generator (Scheme/Sexpr to XML)

# Installation:

`boxcutter` requires the following dependencies to build:
* A sane UNIX system (i.e. gcc, pkg-config, etc.)
* Guile 2.0 (or higher)
* Openbox (to have an actual use)

To compile and install boxcutter run:
```
$ make
$ make install-user
# make install
```

# Using boxcutter:

Boxcutter currently depends on specifically named configuration files.
To edit the rc, use ~/.config/boxcutter/rc.scm. When you're done editing,
simply run `box-cutter` and a file called rc.xml will be generated in that
directory. That file can simply be placed in your ~/.config/openbox directory
to serve as your Openbox rc.xml.

# Boxcutter syntax:

Boxcutter uses a Scheme syntax for configurations. The syntax should be compliant
with Guile version 2.0. However, the configuration can be managed entirely by
custom macros and functions, so it is not necessary to use any additional Scheme
code in your configuration.

All configurations should be declared inside of `(rc ...)` to export the config.
Inside of this, simply put the list of configuration options. Every configuration
option is written in the s-expression syntax: `(<name> <args>*)`. Arguments to
these should be one of the following:

* Numbers
* Strings (enclosed within double quotes: "example")
* More nodes
* Commonly typed exceptions [1]

[1] - These exceptions include:

* yes ("Yes")
* no ("No")
* undermouse ("UnderMouse")
* smart ("Smart")
* x-center (equivalent to "<x>center</x>")
* y-center (equivalent to "<y>center</y>")
* always ("Always")
* never ("Never")
* nonpixel/non-pixel ("Nonpixel")
* top ("Top")
* centered ("Center")
* fixed ("Fixed")

As a general rule, all node names are the same as their XML names. However, names
which use camel case are instead switched to kebab case (so that "myNode" becomes
"my-node" and so on). Additionally, some XML names use snake case, so these too
use kebab case (meaning that "my_node" becomes "my-node").

Finally, line comments can be inserted after one or more semicolons.

A basic example exists below:

```
;; This is an example config.
;; It is nowhere near complete
;; but it does showcase some
;; of boxcutter's features
(rc
  (resistance
    (strenth 10)
    (screen-edge-strength 10)))
```
