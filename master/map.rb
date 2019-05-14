class Node
      attr_accessor :x, :y, :block, :visited
      def initialize(x, y, block, visited)
		@x = x
		@y = y
		@block = block
            @visited = visited
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
      cols = @cell_x_count
      rows = @cell_y_count
      table = Array.new()

	@cell_y_count.times do |x|
            @cell_x_count.times do |y|
                  media = get_cell_type(x).to_s
                  block = spawn_obj(0, 0, media, 50, 50, 0, 0, 1, 0, false)
                  block.x = y*CELL_DIM
                  block.y = x*CELL_DIM
                  table << Node.new(x, y, block, false)
            end
      end
      return table
end

def target_cell(x=50, y=100 )
      # puts "cell [#{@columns[18].x}, #{@columns[18].y}] is at [#{@columns[18].x*CELL_DIM}, #{@columns[18].y*CELL_DIM}]"
      # @temp = spawn_obj(50, 100, "./media/red.png", 50, 50, 0, 0, 1, 0, false)
      x = (x.floor_to(50)/CELL_DIM)
      y = (y.floor_to(50)/CELL_DIM)
      cell_id = 0
      # p "x = #{x} y = #{y}"
      y.times do cell_id+=16 end
      x.times do cell_id+=1 end
      # p "cell id: #{cell_id}"
      return @columns[cell_id]
      # puts "#{x}, #{y}"
end

def visit_tile(object)
	p object
	# p "#{object.x} #{object.y}"
      # object.visited = true
end



def generate_row()
      # puts "generating row #{@cell_y_count+1}"
      x = @columns[@columns.size-1].block.y
	p @columns[@columns.size-1].block.y

            @cell_x_count.times do |y|
                  media = get_cell_type(x).to_s
                  block = spawn_obj(0, 0, "./media/red.png", 50, 50, 0, 0, 1, 0, false)
                  block.x = y*CELL_DIM
                  block.y = x*CELL_DIM
                  @columns << Node.new(x, y, block, false)
            end

      # increment the row count
      @cell_y_count+=1
      # delete the oldest row
      delete_row()
end

def delete_row()
	16.times do |i| @columns.delete_at(0) end
      # puts "current rows: #{@columns.length/@cell_x_count}"
      # puts @columns.size
      # @cell_x_count.times do |y|
      #       if (@columns.size/@cell_x_count > 50)
      #             @columns.delete_at(0)
      #       end
      # end
end


def draw_blocks(blocks)
      blocks.length.times do |block|
            draw_obj_frame(@columns[block].block, :right, 0)
            # p @columns[block].block.keyframes
            # if @columns[block].visited
            #
            # else
            #       draw_obj_frame(@columns[block].block, :right, 1)
            # end

	end
end

def print_mouse_coords
      puts "#{mouse_x} #{mouse_y}"
      # puts "#{(mouse_x).round/CELL_DIM} #{(mouse_y.round)/CELL_DIM}"
end
