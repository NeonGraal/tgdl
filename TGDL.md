# Tiny Graph Description Langauge Reference

_**DRAFT**_

## Core syntax

### Identifiers
Many elements have identifiers. Each identifier is unqiue within a file. Identifiers are **introduced** (become known) in a number of ways and unknown identifiers at the end of parsing a file are a parse error.

### Nodes
Nodes have an identifier and other optional attributes. They are introduced in many ways but the simplest is with a "`.`".
```
.node
```

### Edges
Edges have a start and end node and other optional attributes. They are introduced in many ways but the simplest is with a "`-`". This will make an edged from the _current_ node to the named node, introducing the new node if needed.
```
.node1
-node2
```
