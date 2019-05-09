require 'gosu'
# require './cloud'
require './object'
require './player'

WIDTH = 1000
HEIGHT = 501

def peek_array(array)
	if array[array.length-1]
		return array[array.length-1]
	else
		return nil
	end

end

def get_random_spawn_location(type)
	object = peek_array(@list_of_objs[type])

	if object
		loop do
			seed = rand(HEIGHT)
			# return seed if seed < HEIGHT and seed > 0 and seed > last_obj_height and seed < last_obj_y
			return seed if seed < object.y-100 or seed > object.h*object.scale+100 and seed < HEIGHT-100 and seed > 100
		end
	else
		return 100
	end

		# loop do
		# 	seed = rand(HEIGHT)
		# 	# return seed if seed < HEIGHT and seed > 0 and seed > last_obj_height and seed < last_obj_y
		# 	return seed if seed > last_obj_y-50 or seed < last_obj_height+50 and seed < HEIGHT-100 and seed > 100
		# end

end

class GameWindow < Gosu::Window
      def initialize
            super WIDTH, HEIGHT
            self.caption = "Game"

		@clouds = Array.new()
		@clouds << cloud = spawn_obj(-50, 100, './media/cloud1.png', 846, 540, 4, 0, 0.3, 1, true)

		# @background = spawn_obj(0, 0, './media/background.png', WIDTH, HEIGHT, 0, 0, 1, 0, false)

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
		if rand(100) == 1
			puts "new cloud"
			@clouds << cloud = spawn_obj(-50, get_random_spawn_location(:cloud), './media/cloud1.png', 846, 540, 4, 0, 0.3, 1, false)
		end

		@clouds.each do |cloud|
			update_object(cloud, cloud.velx, cloud.vely)
		end
      end

	#draw
	def draw
		if @clouds
			@clouds.each do |cloud|
				draw_obj(cloud, :right)
			end
		end

		draw_obj(@background, :right)
      end

end

GameWindow.new.show
