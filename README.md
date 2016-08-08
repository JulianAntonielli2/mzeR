# mzeR
Simple maze solving software, written in Ruby.

## Usage

Run using `ruby main.rb maze_file.txt entry_block final_block`.

For example, `ruby main.rb maze.txt [0, 1] [0, 6]`

## Mazes

Mazes should be entered as binary matrices, using 0s for walkable blocks, and 1s for walls.

An example would be
```
#maze.txt
     
        #entry    #finish     
      1 0 1 1 1 1 0 1
      1 0 0 1 0 1 0 1 
      1 1 0 0 0 0 0 1
      1 1 0 1 1 1 1 1
      1 1 0 0 0 1 1 1
      1 1 1 1 1 1 1 1
```
Input mazes should be well-formed: Having only two endpoints.

Remark: A maze may have more than one solution, but mzeR will only output the first solution it finds. This is not guaranteed to be the shortest one.

The user should input which endpoint is the starting block and which one is the final block, if this is not entered, mzeR will arbitrarily select either as entry/finish.

Blocks are referred using a `[row, column]` syntax: rows and columns are numbered starting from 0, and take successive integer values, from top to bottom, and from left to right, respectively.
In the above example, the `[0, 1]` block is the entry (with value of 0), and the block `[0, 6]` is the final point.
