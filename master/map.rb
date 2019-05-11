class Node
      attr_accessor :x, :y, :block
      def initialize(x, y, block)
		@x = x
		@y = y
		@block = block
      end

end

class Fixnum
  def roundup
    return self if self % 50 == 0   # already a factor of 10
    return self + 50 - (self % 50)  # go to nearest factor 10
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
                  table << Node.new(x, y, block)
            end
      end

      return table
end


def generate_row()
      puts "generating row #{@cell_y_count+1}"

      x = @cell_y_count
      1.times do
            @cell_x_count.times do |y|
                  media = get_cell_type(x).to_s
                  block = spawn_obj(0, 0, media, 50, 50, 0, 0, 1, 0, false)
                  block.x = y*CELL_DIM
                  block.y = x*CELL_DIM
                  @columns << Node.new(x, y, block)
            end
      end
      # increment the row count
      @cell_y_count+=1
      # delete the oldest row
      delete_row()
end

def delete_row()
      puts "current rows: #{@columns.length/@cell_x_count}"
      # puts @columns.size
      @cell_x_count.times do |y|
            if (@columns.size/@cell_x_count > 50)
                  @columns.delete_at(0)
            end
      end
end


def draw_blocks(blocks)
      blocks.length.times do |block|
		draw_obj(@columns[block].block)
	end
end

def print_mouse_coords
      puts "#{mouse_x} #{mouse_y}"
      # puts "#{(mouse_x).round/CELL_DIM} #{(mouse_y.round)/CELL_DIM}"
end
