require_relative 'utils'

class Solver
	attr_reader :current

	@initial_maze
	@internal_maze

	#@moves = [nil] #Stack that holds the moves.
	
	def initialize maze
		@initial_maze = maze
		@internal_maze = WalkableMaze.new maze
		@steps = [nil]

		puts "First node: #{maze.start}"
		puts "Last node: #{maze.finish}"
	end

	def solve
		solved = false

		current = @internal_maze.start
		finish = @internal_maze.finish
		i = 0

		loop do
			@internal_maze.visit(current)
			@steps << current

			break if current == finish

			moves = @internal_maze.possible_moves(current)

			loop do 
				current = @steps.pop
				terminate if current.nil?
				moves = @internal_maze.possible_moves(current)

				if !moves.empty?
					@steps << current
					break
				end
			end
			current = moves.first
		end
		win
		
	end

	def win
		puts "\nPath found:"
		@steps.each_with_index do |step, index|
			puts "\t #{index}. #{step}" if index > 0
		end
	end

	def terminate
		puts "invalid maze, no way out."
		exit 0
	end
end