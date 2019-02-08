wayland-server
==============

CHICKEN Scheme bindings for the libwayland server API.

Building
--------

Dependencies:

* CHICKEN 5
* libwayland

Run <code>chicken-install</code> in this directory to build and install the
bindings.

Usage
-----

    (import wayland-server)

### Naming Conventions

Procedures use the usual <code>kebab-case</code> convention. Predicates get a ?
suffix, e.g. <code>wl-list-empty?</code>.

Struct members are available as SRFI-17 getters/setters named
<code>struct-name-member-name</code>.

Enums use the convention <code>enum-prefix/kind</code>, e.g.
<code>wl-seat-capability/pointer</code>.

### Differences from the C API

#### wl\_listener

The <code>make-wl-listener</code> function takes a procedure of one argument
and returns a *wrapped* <code>wl\_listener</code> struct. The argument to this
procedure is the <code>void\*</code> argument that would normally be passed to
a regular <code>wl\_listener</code>.

In C, you would put your <code>wl\_listener</code> inside of another struct
and use the <code>wl\_container\_of</code> macro to access its contents from
the listener's notify function. In Scheme, you should set up a lexical
environment where your data is available, and then create a lambda to pass
to <code>make-wl-listener</code>. Or you could implement the usual callback +
user-data convention with a simple wrapper, like so:

    (define (*make-wl-listener proc arg)
      (make-wl-listener (lambda (wl-arg) (proc arg wl-arg))))

#### wl\_list

The <code>wl\_list\_for\_each</code> family of macros are available as
procedures:

    (wl-list-for-each list proc #!optional (convert values))
    (wl-list-for-each/safe list proc #!optional (convert values))
    (wl-list-for-each/reverse list proc #!optional (convert values))
    (wl-list-for-each/reverse-safe list proc #!optional (convert values))

The <code>convert</code> argument should be a function taking a
<code>wl\_list</code> argument and returning some other data type. It is called
on each node and the result is passed to the procedure <code>proc</code>.

A function <code>wl-list-\>list</code> is provided for converting from
<code>wl\_list</code> to native Scheme lists.
