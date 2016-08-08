class Maze
	attr_reader :start, :finish
	attr_accessor :maze

	@@symbol_parse = { 0 => :empty, 1 => :wall }

	@maze = []

	@start
	@finish

	def initialize mz, start, finish
		@start = start
		@finish = finish

		if mz.is_a? Array
			mz_matrix = []

			mz.each_with_index do |row, index|
				mz_matrix[index] = []
				row.each_with_index do |x, i|
					if x.is_a? Symbol
						mz_matrix[index][i] = x
					else
						mz_matrix[index][i] = @@symbol_parse[x]
					end
				end
			end
			@maze = mz_matrix
		else
			@maze = Maze.get str #metodo de Maze o de str??	
		end
	end

	def is_finish? node
		@finish == node
	end

	def render
		@maze.each do |row|
			print "\t"
			row.each { |x| print  "#{x} " }
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
			@maze[row.row, row.col] = val
		else
			@maze[row][col] = val
		end
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

	def walkable? val
		val == :empty
	end

	def visited? val
		val == :visited
	end

end