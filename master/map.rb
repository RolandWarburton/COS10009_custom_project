class Node
      attr_accessor :x, :y, :block

      def initialize(x, y, block)
		@x = x
		@y = y
		@block = block
      end

end

def generate_cells()

      cols = CELL_X_COUNT
      rows = CELL_Y_COUNT
      table = Array.new(rows)
      items = [0,-1]

	row_index = 0
      while row_index < rows
            table[row_index] = Array.new(2)
            col_index = 0
            while col_index < cols
			row_index < 3 ? (media = "./media/air.png") : (media = "./media/dirt.png")
			block = spawn_obj(0, 0, media, 50, 50, 0, 0, 1, 0, false)
			block.x = col_index*CELL_DIM
			block.y = row_index*CELL_DIM
			p "#{row_index},#{col_index}"

                  table[row_index][col_index] = Node.new(row_index, col_index, block)
                  col_index += 1
            end
		row_index += 1
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
