# DEAR TUTOR. THE HEADER FILES FOR THIS PROJECT CAN BE FOUND AT
# 
require 'gosu'
require 'rounding'
require './object'
require './player'
require './map'
require './ui'
require './powerups'

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
		@powerups = Array.new()
		@blocks = Array.new()

		@screen_scroll_speed = 2

		@player = spawn_player(0,0,"./media/player.png",50,50,0,0,1,1,true)
		@player_powerup_state = :first
		@player.alive = true
		@player.location = get_grid_loc(@player)
		@player.target_location = @player.location
		@player.speed = 5


		@fuelcells = generate_fuel()
		@fuel = 10000

		@font = Gosu::Font.new(self, Gosu::default_font_name, 20)
		@scorebox = spawn_obj(20,100,"./media/score.png",150, 50, 0, 0, 1, 1, true)
		@total_score = spawn_obj(200,100,"./media/score.png",150, 50, 0, 0, 1, 1, true)
		@redore = 0
		@greenore = 0

		# @temp = spawn_obj(@columns[-1].block.x, @columns[-1].block.y, './media/red.png', 50, 50, 0, 0, 1)
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
            @player.location = get_grid_loc(@player)

            # camera controls
            @player.location[1] > 15 ? @tracking  -=@screen_scroll_speed : @tracking = 0

		track_scorebox()
		update_object(@scorebox, @scorebox.velx, @scorebox.vely)
		update_object(@total_score, @total_score.velx, @total_score.vely)
		track_fuel(@fuelcells)
            for f in @fuelcells
                  update_object(f, f.velx, f.vely)
            end
            if @fuel % 400 == 0 then @fuelcells.pop end
            @fuel -= 10

		# p "#{@player.y} #{@tracking}"
		if @player.y < @tracking*-1 then @player.alive = false; @player.vely = 0; @fuelcells.each {@fuelcells.pop} end
		if @player.y > @columns[-1].block.y-50 then @player.alive = false; @player.vely = 0; @fuelcells.each {@fuelcells.pop} end
		if @fuel == 0 then @player.alive = false; @player.vely = 0; @fuelcells.each {@fuelcells.pop} end


		# track_score(@score)

		if @player.y % 50 == 0
			cell_id = target_cell(@player.x, @player.y)
			if @columns[cell_id].block.spritesheet == "./media/fuelore.png" and  @columns[cell_id].visited != true then addfuel(); @fuel = 10000; @powerups << Powerup.new(Gosu.milliseconds + 2500); puts "powerup" end
			if @columns[cell_id].block.spritesheet == "./media/redore.png" and  @columns[cell_id].visited != true then @redore += 1 end
			if @columns[cell_id].block.spritesheet == "./media/greenore.png" and  @columns[cell_id].visited != true then @greenore += 1 end
			@columns[cell_id].visited = true
		end

		if @powerups.size > 0 then @powerups.each {|p| if p.time < Gosu.milliseconds then @powerups.pop end}; @player.speed = 10; @player_powerup_state = :last else @player.speed = 5;  @player_powerup_state = :first end

		if @columns[17].block.y*-1 > @tracking
			generate_row()
			delete_row()
		end

            # if the player is on the target cell. checking x and y.
             # checking the pixels cos otherwise the player does fuycky things
            if (@player.y >= (@player.target_location[1]*CELL_DIM)) and
			(@player.y <=(@player.target_location[1]*CELL_DIM)) and
			(@player.x >= (@player.target_location[0]*CELL_DIM)) and
			(@player.x <= (@player.target_location[0]*CELL_DIM))
                  @player.velx = 0
                  @player.vely = 0
			process_boundaries(@player)
		else
                  # else the player needs to move
                  update_object(@player, @player.velx, @player.vely)
            end


		if @player.alive != false
			if button_down?(Gosu::KbLeft) and @player.vely == 0 and @player.velx ==0 and process_boundaries(@player)
				@player.target_location[0] = (@player.location[0]-1)
				@player.velx = -@player.speed
			end
			if button_down?(Gosu::KbRight) and @player.vely == 0 and @player.velx ==0 and process_boundaries(@player)
				@player.target_location[0] = (@player.location[0]+1)
				@player.velx = @player.speed
			end
			if button_down?(Gosu::KbUp) and @player.vely == 0 and @player.velx ==0 and process_boundaries(@player) and (@player.y > HEIGHT or @tracking == 0)
				@player.target_location[1] = (@player.location[1]-1)
				@player.vely = -@player.speed
			end
			if button_down?(Gosu::KbDown) and @player.vely == 0 and @player.velx ==0 and process_boundaries(@player)
				@player.target_location[1] = (@player.location[1]+1)
				@player.vely = @player.speed
			end
		end
	end


	#draw
	def draw
		# draw clouds
		# if @clouds then @clouds.each { |cloud| draw_obj(cloud, :right) } end

		Gosu.translate(0, @tracking) do
			draw_blocks(@columns)


			if @temp then draw_obj(@temp, :right) end

			if @player.alive then draw_obj(@player, @player_powerup_state) else @font.draw_text("GAME OVER\nScore = #{@redore+(@greenore*3)}", 200, 300+@tracking*-1, 1, 4.0, 4.0, Gosu::Color::BLACK) end

			@fuel > 3000 ? frame = :first : frame = :last
			if @fuelcells then @fuelcells.each { |fuel| draw_obj(fuel, frame) } end

			draw_obj(@scorebox, :first)
			draw_obj(@total_score, :first)
			@font.draw_text("red ore: #{@redore}\ngreen ore: #{@greenore}", @scorebox.x+20, @scorebox.y+5, 1, 1.0, 1.0, Gosu::Color::BLACK)
			@font.draw_text("SCORE: #{@redore+(@greenore*3)}", @total_score.x+15, @total_score.y+15, 1, 1.0, 1.0, Gosu::Color::BLACK)

			end
		end
	end
# thanks for playing :)

GameWindow.new.show
