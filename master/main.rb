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
            @cell_x_count = WIDTH/CELL_DIM
            @cell_y_count = (HEIGHT/CELL_DIM)+1
            puts "map width (x) = #{@cell_y_count}"
            puts "map height (y) = #{@cell_x_count}"

		@columns = generate_cells()
		@clouds = Array.new()
		@blocks = Array.new()
            @player = spawn_player(0,150,'./media/player.png',50,50,0,0,1,1,true)
            @player.location = get_grid_loc(@player)
            @player.target_location = @player.location


            @fuelcells = generate_fuel()
            @fuel = 20000

            target_cell()



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
                  print_mouse_coords
            when Gosu::KbLeft
            end

      end

      # update
      def update
            @player.location = get_grid_loc(@player)

            # camera controls
            @player.location[1] > 15 ? @tracking  -=5 : @tracking = 0


            for f in @fuelcells
                  update_object(f, f.velx, f.vely)
            end
            if @fuel % 500 == 0 then @fuelcells.pop end
            # @fuel -= 100

            track_fuel(@fuelcells)
            # @fuelcells -= 1


            # puts "#{pix_round(@player)[1]} > #{@columns[-1].x*CELL_DIM}"
            if  pix_round(@player)[1]+HEIGHT > @columns[-1].x*CELL_DIM
                  generate_row()
            end

            # DEBUG STUFF
            # p "#{@player.location} -> #{@player.target_location}"

            # spawning in clouds at random
            # if rand(100) == 1 and @clouds.length <1 then @clouds << cloud = spawn_obj(-50, rand(HEIGHT), './media/cloud1.png', 846, 540, 4, 0, 0.3, 1, false) end


            # if the player is on the target cell. checking x and y.
            #  checking the pixels cos otherwise the player does fuycky things
            if @player.y == @player.target_location[1]*CELL_DIM and @player.x == @player.target_location[0]*CELL_DIM
                  @player.velx = 0
                  @player.vely = 0
            else
                  # else the player needs to move
                  update_object(@player, @player.velx, @player.vely)
            end



            if button_down?(Gosu::KbLeft) and @player.vely == 0 and @player.velx ==0 and process_boundaries(@player)
                  @player.target_location[0] = (@player.location[0]-1)
                  @player.velx = -2
			visit_tile(target_cell(@player.x, @player.y))
            end
            if button_down?(Gosu::KbRight) and @player.vely == 0 and @player.velx ==0 and process_boundaries(@player)
                  @player.target_location[0] = (@player.location[0]+1)
                  @player.velx = 2
			visit_tile(target_cell(@player.x, @player.y))
            end
            if button_down?(Gosu::KbUp) and @player.vely == 0 and @player.velx ==0 and process_boundaries(@player)
                  @player.target_location[1] = (@player.location[1]-1)
                  @player.vely = -2
			visit_tile(target_cell(@player.x, @player.y))
            end
            if button_down?(Gosu::KbDown) and @player.vely == 0 and @player.velx ==0 and process_boundaries(@player)
                  @player.target_location[1] = (@player.location[1]+1)
                  @player.vely = 10
                  visit_tile(target_cell(@player.x, @player.y))
            end

		# @clouds.each do |cloud|
		# 	update_object(cloud, cloud.velx, cloud.vely)
		# end





      end

	#draw
	def draw
            # draw clouds
            # if @clouds then @clouds.each { |cloud| draw_obj(cloud, :right) } end

                  Gosu.translate(0, @tracking) do
                        draw_blocks(@columns)
                        draw_obj(@player, :right)
                        if @temp then draw_obj(@temp, :right) end
                        @fuel > 15000 ? frame = 0 : frame = 1
                        # if @fuelcells then @fuelcells.each { |fuel| draw_obj_frame(fuel, :right, frame) } end
                  end
            end
      end
# thanks for playing :)

GameWindow.new.show
