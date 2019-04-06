# Tiny Graph Description Language Reference

_**DRAFT**_

## Core syntax

### Identifiers
Many elements have identifiers. Each identifier is unique within a file. Identifiers are **introduced** (become known) in a number of ways and unknown identifiers at the end of parsing a file are a parse error.

### Nodes
Nodes have an identifier and other optional attributes. They are introduced in many ways but the simplest is with a "`.`". This will also set the _current_ node to be the newly introduced node.
```
.node
```

### Edges
Edges have a start and end node and other optional attributes. They are introduced in many ways but the simplest is with a "`-`". This will make an edge
 from the _current_ node to the named node, introducing the new node if needed. The _current_ will not be changed.
```
.node1
-node2
```

Similarly the following:
```
node1-node2
```
will introduce both `node1` and `node2` and set the _current_ node to be `node1`.
