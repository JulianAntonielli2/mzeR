# Delegar metodos de maze. Hacer modulo maybe.

class Maze
	attr_reader :start, :finish
	attr_accessor :maze

	@@symbol_parse = { 0 => :empty, 1 => :wall }

	@@int_parse = Hash.new { |hash, key| hash[key] = key }	#Testing, for rendering solution purposes.
	@@int_parse[:empty], @@int_parse[:wall] = 0, 1			#Look for more elegant way.

	@maze = []

	def initialize mz, start = nil, finish = nil
		@start = start
		@finish = finish

		if mz.is_a? Array
			@maze = Maze.array_to_maze_matrix mz
		elsif mz.is_a? File
			@maze = Maze.get str #metodo de Maze o de str??	
		end

		@start = find_endpoint if @start.nil?
		@finish = find_endpoint @start if @finish.nil?
	end

	# Finds an endpoint. If given the starting position, it finds the exit to the maze.
	def find_endpoint start = nil
		[:top, :left, :bottom, :right].each { |side| sides[side] = maze_side(side) }

		sides.each do |side| #Revisar este each!!!!
			side.each_with_index do |block, index|
				if block.walkable?
					pos = get_position(side, index)
					return pos if pos != start 
				end
			end
		end

	end

	def maze_side side
		side = []

		case side
		when :top
			@maze.first
		when :bottom
			@maze.last
		when :left
			maze.each { |row| side << row.first }
			side
		when :right
			maze.each { |row| side << row.last }
			side
		end
	end

	def get_position side, index
		position_by_side = { top: 0, bottom: rows - 1, left: 0, right: columns - 1}
		case side
		when :top, :bottom
			Position.new(position_by_side[side], index)
		when :left, :right
			Position.new(index, position_by_side)
		end
	end


	def self.array_to_maze_matrix ari # Perhaps should be class method?
		mz_matrix = []

		ari.each_with_index do |row, index|
			mz_matrix[index] = []
			row.each_with_index do |x, i|
				if x.is_a? Symbol
					mz_matrix[index][i] = x
				else
					mz_matrix[index][i] = @@symbol_parse[x]
				end
			end
		end
		mz_matrix		
	end

	def self.file_to_maze_matrix file
		mz_matrix = []
		file.each do |line|
			line.gsub!(/[(\t) ]/, '')
			line.each do |char|
				next if char == '#'
				
			end
			 	
		end
	end

	def walkable? val
		val == :empty
	end

	def is_finish? pos
		@finish == pos
	end

	def render
		@maze.each do |row|
			print "\t"
			row.each { |x| print  "#{@@int_parse[x]} " }
			puts ''
		end
	end

	def copy
		mz_matrix = []
		@maze.each_with_index do |row, index|
			mz_matrix[index] = [] 
			row.each_with_index do |x, i|
				mz_matrix[index][i] = x
			end
		end

		mz = Maze.new(mz_matrix, start, finish)
	end

	def [] (row, col = nil)
		if row.is_a? Position
			@maze[row.x, row.y]
		else
			@maze[row][col]
		end
	end

	def []= (row, col = nil, val)
		if row.is_a? Position
			@maze[row.row][row.col] = val
		else
			@maze[row][col] = val
		end
	end

	def rows
		@maze.size		
	end

	def columns
		@maze[0].size
	end
end


class WalkableMaze < Maze
	attr_accessor :current

	def initialize maze
		if maze.is_a? Maze
			@maze = maze.copy.maze
			@start = maze.start
			@finish = maze.finish
		end
	end

	def visit node
		@current = node
		self[node.row, node.col] = :visited
	end

	def possible_moves node
		moves = []
		[-1, 1].each do |i|
			move_col = [node.row, node.col + i]
			move_row = [node.row + i, node.col]
			moves << Position.new(*move_col) if walkable?(self[*move_col]) && (node.row >= 0) && (node.col + i >= 0)
 			moves << Position.new(*move_row) if walkable?(self[*move_row]) && node.row + i >= 0 && node.col + i >= 0
		end
		moves
	end

	def visited? val
		val == :visited
	end

end