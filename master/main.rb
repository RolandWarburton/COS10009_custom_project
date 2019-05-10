require 'gosu'
# require './cloud'
require './object'
require './player'
require './map'

WIDTH = 800
HEIGHT = 1000
CELL_DIM = 50
CELL_X_COUNT = WIDTH/CELL_DIM
CELL_Y_COUNT = HEIGHT/CELL_DIM



class GameWindow < Gosu::Window
      def initialize
            super WIDTH, HEIGHT
            self.caption = "Game"

		@columns = generate_cells()
		@clouds = Array.new()
		@blocks = Array.new()
		@clouds << cloud = spawn_obj(-50, 100, './media/cloud1.png', 846, 540, 4, 0, 0.3, 1, true)
		# @blocks << block = spawn_obj(0, 0, './media/dirt.png', 50, 50, 0, 0, 1, 1, false)

		# @background = spawn_obj(0, 0, './media/background.png', WIDTH-1, HEIGHT-1, 0, 0, 1, 0, false)

            @key = {
                  kb_left: Gosu::KbLeft,
                  kb_right: Gosu::KbRight,
            }

		@list_of_objs = {
			# frames, and time in secs
			:cloud => @clouds
		}
      end

      # runs before update
      def button_up(id)
            # if id == @key[:kb_left]
            #       @cloud.stop_move
            # end
      end

      # update
      def update
		if rand(100) == 1 then @clouds << cloud = spawn_obj(-50, rand(HEIGHT), './media/cloud1.png', 846, 540, 4, 0, 0.3, 1, false) end

		@clouds.each do |cloud|
			update_object(cloud, cloud.velx, cloud.vely)
		end
      end

	#draw
	def draw
		if @clouds then @clouds.each { |cloud| draw_obj(cloud, :right) } end
		if @blocks then @blocks.each { |block| draw_obj(block, :right) } end

		draw_blocks(@columns)
		draw_obj(@background, :right)
      end

end

GameWindow.new.show
