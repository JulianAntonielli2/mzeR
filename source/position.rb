class Position
	attr_reader :row, :col

	def initialize row, col
		@row, @col = row, col
	end 

	def to_s
		"[#{row}, #{col}]"
	end

	def == pos
		false unless pos.is_a?(Position)
		
		row == pos.row && col == pos.col
	end
end