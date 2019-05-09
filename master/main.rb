require 'gosu'
# require './cloud'
require './object'
require './player'

WIDTH = 1000
HEIGHT = 500

def get_random_spawn_location(object)
	last_obj = object[object.length-1].y
	loop do
		seed = rand(HEIGHT)
		return seed if seed < HEIGHT-100 and seed > 100 and seed + last_obj > last_obj or seed + last_obj < last_obj
	end

end

class GameWindow < Gosu::Window
      def initialize
            super WIDTH, HEIGHT
            self.caption = "Game"

            # takes spawn_x, spawn_y, source, width, height
            # @cloud = Obs.new(0, 240, './media/cloud1.png', 846, 540)
		@clouds = Array.new()
		@clouds << @cloud = spawn_obj(-1, rand(HEIGHT-100), './media/cloud1.png', 846, 540, 4, 0, 0.3, 1, true)



            # @cloud2 = spawn_obj(0, 240, './media/cloud1.png', 846, 540, 4, 0, 0.3, 1)
		@background = spawn_obj(0, 0, './media/background.png', WIDTH, HEIGHT, 0, 0, 1, 0, false)

            # @player = Player.spawn_player(100, 240, './media/hook.png', 50, 50)

            @key = {
                  kb_left: Gosu::KbLeft,
                  kb_right: Gosu::KbRight,
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
		if rand(100) == 1
			r = get_random_spawn_location(@clouds)
			@clouds << @cloud = spawn_obj(-1, get_random_spawn_location(@clouds), './media/cloud1.png', 846, 540, 4, 0, 0.3, 1, true)
			puts "spawned cloud #{r}"
		end

		@clouds.each do |cloud|
			if @clouds.length > 3
				@clouds[0].wrapping = false
			end
			update_object(cloud, 4, 0)
		end
      end

	#draw
	def draw
		@clouds.each do |cloud|
			draw_obj(cloud, :right)
		end

		draw_obj(@background, :right)
      end

end

# class Animation
# 	attr_accessor: x, y, frames, ms_per_frame, current_frame
# end
#
# def update_animation(anim_to_update)
# 	anim_to_update.current_frame += anim_to_update.ms_per_frame
# 	if (anim_to_update.current_frame > anim_to_update.length)
#
# end
#
# def draw_animation(anim_to_draw)
# 	current_frame = math.floor(anim_to_draw.current_frame)
# 	Gosu.draw(x, y, anim_to_draw.frames[current_frame])
# end

GameWindow.new.show
