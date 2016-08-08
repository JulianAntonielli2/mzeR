# mzeR
Simple maze solving software, written in Ruby.


## Mazes

Mazes should be entered as binary matrices, using 0s for walkable blocks, and 1s for walls.

An example would be
```
      1 1 1 1 1 1
  ->  0 0 0 1 0 0 ->
      1 1 0 0 0 1
      1 1 0 1 1 1
      1 1 0 0 0 1
      1 1 1 1 1 1
```
Input mazes should be well-formed: Having only two endpoints.

Remark: A maze may have more than one solution, but mzeR will only output the first solution it finds. This is not guaranteed to be the shortest one.

The user should input which endpoint is the starting block and which one is the final block, if this is not entered, mzeR will arbitrarily select either as entry/finish.
