# unbox
OpenBox rc.xml Generator (Scheme/Sexpr to XML)

# Installation:

`unbox` requires the following dependencies to build:
* A sane UNIX system (i.e. gcc, pkg-config, etc.)
* Guile 2.0 (or higher)
* Openbox (to have an actual use)

To compile and install unbox run:
```
$ make
$ make install-user
# make install
```

# Using unbox:

unbox currently depends on specifically named configuration files.
To edit the rc, use ~/.config/unbox/rc.scm. When you're done editing,
simply run `unbox` and a file called rc.xml will be generated in that
directory. That file can simply be placed in your ~/.config/openbox directory
to serve as your Openbox rc.xml.

Because unbox does not currently account for proper formatting, it may be
a good idea to apply an XML formatting tool on the output to make it easier
to read. In order to do this, you can run:
```
$ xmllint --format ~/.config/unbox/rc.xml >~/.config/unbox/rc.xml
```
Or, to copy it to the correct location for Openbox, run:
```
$ xmllint --format ~/.config/unbox/rc.xml >~/.config/openbox/rc.xml
```

Note: Future versions of unbox will incorporate this as a flag

# unbox syntax:

unbox uses a Scheme syntax for configurations. The syntax should be compliant
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
;; of unbox's features
(rc
  (resistance
    (strenth 10)
    (screen-edge-strength 10)))
```

# Contributing

If you're interested in helping out this project or find a problem with it, there
are a number of ways you can contribute. One of the best ways is to open up a
issue on the [Github repository](https://github.com/nv-vn/unbox/issues) to
report bugs, missing features, or inconsistent behaviour. Additionally, you are
encouraged to fork the repository and add features to improve the project for
others (or fix bugs that you find). Finally, if you're interested in contributing
to the community as a whole, please help with documentation efforts or by sharing
your configs so that others can use them as examples to build off of.
