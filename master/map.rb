class Node
      attr_accessor :block, :visited
      def initialize(block, visited)
		@block = block
            @visited = visited
      end

end

def get_cell_type(row_index)
	if row_index < 4 then return "./media/air.png" end
      # which sprite should i use for this tile?
	case rand(10)
	when 1
		media = "./media/greenore.png"
	when 2
		media = "./media/redore.png"
	else
		media = "./media/dirt.png"
	end

      if row_index < 4 then return media end

      # return a default sprite if no sprite is specified
      if media then return media else return "./media/dirt.png" end
end

def generate_cells()
      cols = @cell_x_count
      rows = @cell_y_count
      table = Array.new()

	@cell_x_count.times do |x|
            @cell_y_count.times do |y|
                  media = get_cell_type(x).to_s
                  block = spawn_obj(0, 0, media, 50, 50, 0, 0, 1, 0, false)
                  block.x = y*CELL_DIM
                  block.y = x*CELL_DIM
                  table << Node.new(block, false)
            end
      end
      return table
end

def target_cell(x, y)
      # puts "cell [#{@columns[18].x}, #{@columns[18].y}] is at [#{@columns[18].x*CELL_DIM}, #{@columns[18].y*CELL_DIM}]"
      # @temp = spawn_obj(50, 100, "./media/red.png", 50, 50, 0, 0, 1, 0, false)
      cell_id = 0
      # p "x = #{x} y = #{y}"
      y.times do cell_id+=16 end
      x.times do cell_id+=1 end
      # p "cell id: #{cell_id}"
      return @columns[cell_id]
      # puts "#{x}, #{y}"
end

def visit_tile(object)
	# p object
	# p "#{object.x} #{object.y}"
      # object.visited = true
end



def generate_row()
	# create a cell for each position in the row
	@cell_y_count.times do
		# get coords for the start of the last row
		x = @columns[-16].block.y+50
		y = @columns[-16].block.x
		# draw the cell in
		block = spawn_obj(y, x, "./media/red.png", 50, 50, 0, 0, 1, 0, false)
		@columns << Node.new(block, false)
	end

end

# removes the oldest 16 cells (16 cells = 1 row)
def delete_row()
	16.times do @columns.delete_at(0) end
end


def draw_blocks(columns)
	columns.length.times do |i|
            # p @columns[i].visited
            @columns[i].visited ? draw_obj_frame(@columns[i].block, :right, -1) : draw_obj_frame(@columns[i].block, :right, 0)
	end
end

def print_mouse_coords
      puts "#{mouse_x} #{mouse_y}"
      # puts "#{(mouse_x).round/CELL_DIM} #{(mouse_y.round)/CELL_DIM}"
end
