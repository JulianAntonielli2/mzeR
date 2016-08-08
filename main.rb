require_relative 'utils'

maze = []
maze[0] = [1, 1, 1, 1, 1, 1]
maze[1] = [0, 0, 0, 0, 0, 1]
maze[2] = [1, 1, 0, 1, 0, 1]
maze[3] = [1, 1, 0, 0, 0, 0]
maze[4] = [1, 1, 1, 1, 1, 1]


# Creates an object representing a Maze.
# Params: maze matrix, start position, finish position.
mz = Maze.new(maze, Position.new(1, 0), Position.new(3, 5)) 

puts "\nMaze:\n"
mz.render
puts ""


solver = Solver.new mz
solver.solve
#solver.solve