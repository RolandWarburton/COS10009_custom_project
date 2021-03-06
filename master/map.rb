class Node
	attr_accessor :block, :visited
	def initialize(x, y, block, visited)
		@x = x
		@y = y
		@block = block
		@visited = visited
	end

end

# which sprite should i use for this tile?
def get_cell_type(row_index)
	if row_index < 4 then return "./media/air.png" end

	case rand(20)
	when 1; media = "./media/greenore.png"
	when 2; media = "./media/redore.png"
	when 3; media = "./media/fuelore.png"
	else; media = "./media/dirt.png"
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
                  block = spawn_obj(nil, nil, media, 50, 50, 0, 0, 1, 0, false)
                  block.x = y*CELL_DIM
                  block.y = x*CELL_DIM
                  table << Node.new(x, y, block, false)
            end
      end
      return table
end

def target_cell(x=50, y=100 )
	tracking_offset = 0;
	if (@tracking < 0) then tracking_offset = 50 end

      x, y = (x/CELL_DIM), ((y+@tracking.floor_to(50) + tracking_offset)/CELL_DIM)

      cell_id = 0
      y.times do cell_id+=16 end
      x.times do cell_id+=1 end

	if @columns[cell_id].block.y < @player.y
		cell_id+=16
		@columns[cell_id].visited = true
	end
      return cell_id
end

	# create a cell for each position in the row
def generate_row()
	@cell_y_count.times do
		# get coords for the start of the last row
		x, y = @columns[-16].block.y+50, @columns[-16].block.x
		@columns << Node.new(x, y, spawn_obj(y, x, get_cell_type(10).to_s, 50, 50, 0, 0, 1, 0, false), false)
	end
end

# removes the oldest 16 cells (16 cells = 1 row)
def delete_row()
	16.times do @columns.delete_at(0) end
end


def draw_blocks(columns)
	columns.length.times do |i|
		@columns[i].visited ? draw_obj(@columns[i].block, :last) : draw_obj(@columns[i].block, :first)
	end
end

def print_mouse_coords
      puts "#{mouse_x} #{mouse_y}"
      # puts "#{(mouse_x).round/CELL_DIM} #{(mouse_y.round)/CELL_DIM}"
end
