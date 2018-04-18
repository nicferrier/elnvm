# default Emacs nvm setup

Emacs should be able to use nvm for node more easily.

This is a fairly easy solution.

Install the file. Have it initialzed at Emacs init.

In emacs shell use the alias:

```
$node
```

or:

```
$nodejs
```

or:

```
$npm
```

to refer to the values of those paths.

The value is also set in the PATH environment.


## Why use nvm?

I started using nvm (and fearing it was probably a mistake) because I
couldn't get a Debian packaged nvm that allowed me to install global
modules.

There are a couple of hacks for this but I think the best way is to
just separate package systems from developer tooling.

I wish package systems would package developer tooling installers
instead of developer tooling.
