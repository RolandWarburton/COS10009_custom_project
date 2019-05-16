require 'gosu'
require 'rounding'
# require './cloud'
require './object'
require './player'
require './map'
require './ui'

WIDTH = 800
HEIGHT = 1000
CELL_DIM = 50
CELL_X_COUNT = (WIDTH/CELL_DIM)
CELL_Y_COUNT = (HEIGHT/CELL_DIM)



class GameWindow < Gosu::Window
      def initialize
            super WIDTH, HEIGHT
            self.caption = "Game"
            @cell_y_count = WIDTH/CELL_DIM
            @cell_x_count = (HEIGHT/CELL_DIM)+1
            puts "map width (y) = #{@cell_y_count}"
            puts "map height (x) = #{@cell_x_count}"

		@columns = generate_cells()
		@clouds = Array.new()
		@blocks = Array.new()
            # @player = spawn_player(0,0,"./media/player.png",50,50,0,0,1,1,true)
            # @player.location = get_grid_loc(@player)
            # @player.target_location = @player.location


            @fuelcells = generate_fuel()
            @fuel = 20000

		# p "#{@columns[-16].block.x}, #{@columns[-16].block.y}"
		# @temp = spawn_obj(@columns[-1].block.x, @columns[-1].block.y, './media/red.png', 50, 50, 0, 0, 1)
		# generate_row()


            # target_cell()
		# generate_row()
		
		# @clouds << cloud = spawn_obj(-50, 100, './media/cloud1.png', 846, 540, 4, 0, 0.3, 1, true)
		# @blocks << block = spawn_obj(0, 0, './media/dirt.png', 50, 50, 0, 0, 1, 1, false)

		# @background = spawn_obj(0, 0, './media/background.png', WIDTH-1, HEIGHT-1, 0, 0, 1, 0, false)

            @key = {
                  kb_left: Gosu::KbLeft,
                  kb_right: Gosu::KbRight,
            }

            def needs_cursor?
                  true
            end
      end

      # runs before update
      def button_down(id)
            case id
		when Gosu::MsLeft
			print_mouse_coords()
            when Gosu::KbB
                  generate_row()
            when Gosu::KbLeft
            end

      end

      # update
      def update
            # @player.location = get_grid_loc(@player)

            # camera controls
            # @player.location[1] > 15 ? @tracking  -=5 : @tracking = 0


            for f in @fuelcells
                  update_object(f, f.velx, f.vely)
            end
            if @fuel % 500 == 0 then @fuelcells.pop end
            @fuel -= 10

		# track_fuel(@fuelcells)

		# if @player.y % 50 == 0
		# 	cell_id = target_cell(@player.x, @player.y)
		# 	@columns[cell_id].visited = true
		# end

		# if @columns[17].block.y*-1 > @tracking
		# 	generate_row()
		# 	delete_row()
		# end

            # if the player is on the target cell. checking x and y.
            #  checking the pixels cos otherwise the player does fuycky things
		# and @player.x == @player.target_location[0]*CELL_DIM
            # if (@player.y >= (@player.target_location[1]*CELL_DIM)) and
		# 	(@player.y <=(@player.target_location[1]*CELL_DIM)) and
		# 	(@player.x >= (@player.target_location[0]*CELL_DIM)) and
		# 	(@player.x <= (@player.target_location[0]*CELL_DIM))
            #       @player.velx = 0
            #       @player.vely = 0
		# 	process_boundaries(@player)
		# else
            #       # else the player needs to move
            #       update_object(@player, @player.velx, @player.vely)
            # end


            # if button_down?(Gosu::KbLeft) and @player.vely == 0 and @player.velx ==0 and process_boundaries(@player)
            #       @player.target_location[0] = (@player.location[0]-1)
            #       @player.velx = -10
            # end
            # if button_down?(Gosu::KbRight) and @player.vely == 0 and @player.velx ==0 and process_boundaries(@player)
            #       @player.target_location[0] = (@player.location[0]+1)
            #       @player.velx = 10
            # end
            # if button_down?(Gosu::KbUp) and @player.vely == 0 and @player.velx ==0 and process_boundaries(@player)
            #       @player.target_location[1] = (@player.location[1]-1)
            #       @player.vely = -10
            # end
            # if button_down?(Gosu::KbDown) and @player.vely == 0 and @player.velx ==0 and process_boundaries(@player)
            #       @player.target_location[1] = (@player.location[1]+1)
            #       @player.vely = 10
            # end
	end

	#draw
	def draw
		# draw clouds
		# if @clouds then @clouds.each { |cloud| draw_obj(cloud, :right) } end

		# Gosu.translate(0, @tracking) do
			draw_blocks(@columns)
			# draw_obj(@player, :first)
			# if @temp then draw_obj(@temp, :right) end
			@fuel > 15000 ? frame = :first : frame = :last
			if @fuelcells then @fuelcells.each { |fuel| draw_obj(fuel, frame) } end
			end
		# end
	end
# thanks for playing :)

GameWindow.new.show
