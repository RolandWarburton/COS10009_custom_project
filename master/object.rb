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

def spawn_obj(x, y, spritesheet, w, h, velx, vely, scale, zaxis, wrapping)
	puts "spawning object #{spritesheet}"
	tiles = Gosu::Image.load_tiles(spritesheet, w, h)
	Obj.new(x, y, tiles, w, h, velx, vely, scale, zaxis, wrapping)
end

# reads all of the keyframes for all sprites of a particular object
def get_keyframes(object)
	object.tiles.length > 0 ? (last_frame = object.tiles.length) : (last_frame = 1)
	
	if object.tiles.length > 0
		keyframes = {
			:right => Animation.new(object.tiles[0..last_frame], 0.4)
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

# determines if an object needs to wrap the screen
def process_boundaries(object)
	if object.x > WIDTH+300 or object.x < -300
		if !object.wrapping
			@clouds.delete_at(0)
			puts "deleted cloud"
		else
			object.x = -200
		end
	end
end



def draw_obj(object, direction)
	if object
		object.keyframes[direction].start.draw(object.x, object.y, object.zaxis, object.scale , object.scale)
	end
end
