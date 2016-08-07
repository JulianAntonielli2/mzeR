require_relative 'utils'

#Leer archivo


maze = []
maze[0] = [1, 1, 1, 1, 1, 1]
maze[1] = [0, 0, 0, 0, 0, 1]
maze[2] = [1, 1, 0, 1, 0, 1]
maze[3] = [1, 1, 0, 0, 0, 0]
maze[4] = [1, 1, 1, 1, 1, 1]

mz = Maze.new(maze, Node.new(1, 0), Node.new(3, 5))

mz.render