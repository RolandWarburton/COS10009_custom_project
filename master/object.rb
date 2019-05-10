require 'gosu'
require './animation'

class Obj
	attr_accessor :x, :y, :w, :h, :tiles, :keyframes, :scale, :zaxis, :wrapping, :velx, :vely
	def initialize(x, y, tiles, w, h, velx, vely, scale, zaxis, wrapping)
		@x, @y = x, y
		@velx = velx
		@vely = vely
		@scale = scale
		@zaxis = zaxis
		@wrapping = wrapping
		@h = h
		@w = w
		@tiles = tiles
		# instance a new animation
		@keyframes = get_keyframes(self)
	end
end

def spawn_obj(x=0, y=0, spritesheet='./media/dirt.png', w=100, h=100, velx=0, vely=0, scale=1, zaxis=1, wrapping=false)
	# puts "spawning object #{spritesheet}"
	tiles = Gosu::Image.load_tiles(spritesheet, w, h)
	Obj.new(x, y, tiles, w, h, velx, vely, scale, zaxis, wrapping)
end

def get_random_spawn_location(type)
	if @list_of_objs[type].last
		object = @list_of_objs[type].last
		loop do
			seed = rand(HEIGHT)
			return seed if seed < object.y-100 or seed > object.h*object.scale+100 and seed < HEIGHT-100 and seed > 100
		end
	else
		return 100
	end
end


# reads all of the keyframes for all sprites of a particular object
def get_keyframes(object)
	# object.tiles.length > 0 ? (last_frame = object.tiles.length) : (last_frame = 1)
	if object.tiles.length > 0
		keyframes = {
			:right => Animation.new(object.tiles[0..object.tiles.length], 0.4)
		}
	end

	return keyframes
end


# moves objects around
def update_object(object, x, y)
	object.x += x
	object.y += y
	# wrap at the end of the screen
	process_boundaries(object)
end

def floor_zero(x,y)
	return [x > 0 ? x : 0, y > 0 ? y : 0]
end

# return an objects location on the grid
def get_current_cell(object)
	x = object.x/CELL_DIM
	y = object.y/CELL_DIM
	coords = floor_zero(x,y)
	# puts "#{coords[0]} #{ coords[1]}"
	return coords

end

# determines if an object needs to wrap the screen
def process_boundaries(object)
	coords = get_current_cell(object)
	# if its outside of the map area. measured in cells
	if coords[0] > CELL_X_COUNT or coords[0] < -3
		if !object.wrapping
			@clouds.delete_at(0)
		else
			object.x = -200
		end
	end
end



def draw_obj(object, direction=:right)
	if object then object.keyframes[direction].start.draw(object.x, object.y, object.zaxis, object.scale , object.scale) end
end
