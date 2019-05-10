class Node
      attr_accessor :x, :y, :block

      def initialize(x, y, block)
		@x = x
		@y = y
		@block = block
      end

end

def get_cell_type(row_index)
      # which sprite should i use for this tile?
      if row_index > 4 then media = "./media/dirt.png" end
      if row_index < 4 then media = media = "./media/air.png" end

      # return a default sprite if no sprite is specified
      if media then return media else return "./media/dirt.png" end
end


def generate_cells()

      cols = CELL_X_COUNT
      rows = CELL_Y_COUNT
      table = Array.new(rows)

	row_index = 0
      while row_index < rows
            table[row_index] = Array.new(2)
            col_index = 0
            while col_index < cols
                  media = get_cell_type(row_index).to_s

			# row_index < 3 ? (media = "./media/air.png") : (media = "./media/dirt.png")
			block = spawn_obj(0, 0, media, 50, 50, 0, 0, 1, 0, false)
			block.x = col_index*CELL_DIM
			block.y = row_index*CELL_DIM
			# p "#{row_index},#{col_index}"

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
			draw_obj(col.block)
		end
	end
end
