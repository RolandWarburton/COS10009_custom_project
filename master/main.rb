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
            puts "map width = #{CELL_X_COUNT}"
            puts "map height = #{CELL_Y_COUNT}"

		@columns = generate_cells()
		@clouds = Array.new()
		@blocks = Array.new()
            @player = spawn_player(0,150,'./media/player.png',50,50,0,0,1,1,true)
            @player.target_location = get_current_cell(@player)

		# @clouds << cloud = spawn_obj(-50, 100, './media/cloud1.png', 846, 540, 4, 0, 0.3, 1, true)
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
            def needs_cursor?
                  true
            end
      end

      # runs before update
      def button_down(id)
            case id
            when Gosu::KbRight

            when Gosu::KbLeft

      end

      # update
      def update
            @player.location = get_current_cell(@player)



            # if the player has a new target cell
            if @player.location[0] != @player.target_location[0]
                  update_object(@player, @player.velx, @player.vely)
            else
                  # else the player has no more movements to do :)
                  @player.target_location = @player.location
                  @player.velx = 0
                  @player.vely = 0
            end

		# if rand(100) == 1 and @clouds.length <1 then @clouds << cloud = spawn_obj(-50, rand(HEIGHT), './media/cloud1.png', 846, 540, 4, 0, 0.3, 1, false) end

            # do things every frame. ie. continuously
            if button_down?(Gosu::KbRight)
                  @player.target_location[0] = @player.location[0]+1
                  @player.velx = 2
                  # do some stuff continuously
            end
            if button_down?(Gosu::KbLeft)
                  @player.target_location[0] = @player.location[0]-1
                  @player.velx = -2
                  # do some stuff continuously
            end

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
            draw_obj(@player, :right)
      end

end

GameWindow.new.show
