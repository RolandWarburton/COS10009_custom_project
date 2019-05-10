class Node
      attr_accessor :x, :y, :block

      def initialize(x, y, block)
		@x = x
		@y = y
		@block = block
      end

end

def generate_cells()

      cols = CELL_Y_COUNT
      rows = CELL_X_COUNT
      table = Array.new(rows)
      items = [0,-1]


      table.each_with_index do |col, row_index|
            table[row_index] = Array.new(2)
            col_index = 0
            while col_index < cols
			block = spawn_obj(0, 0, './media/dirt.png', 50, 50, 0, 0, 1, 0, false)
			block.x = row_index*CELL_DIM
			block.y = col_index*CELL_DIM

                  table[row_index][col_index] = Node.new(row_index, col_index, block)
                  col_index += 1
            end
      end

      return table
end


def draw_blocks(blocks)
	for row in blocks
		for col in row
			# p col.block.x
			draw_obj(col.block)
		end
	end
end
