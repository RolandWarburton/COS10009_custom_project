require 'gosu'
require './animation'

class Obj
	attr_accessor :x, :y, :frames, :scale, :zaxis, :wrapping
	def initialize(x, y, frames, w, h, velx, vely, scale, zaxis, wrapping)
		@frames = frames
		@x, @y = x, y
		@velx = velx
		@vely = vely
		@scale = scale
		@zaxis = zaxis
		@wrapping = wrapping
	end
end

def spawn_obj(x, y, spritesheet, w, h, velx, vely, scale, zaxis, wrapping)
	frames = Gosu::Image.load_tiles(spritesheet, w, h)
	Obj.new(x, y, frames, w, h, velx, vely, scale, zaxis, wrapping)
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
	if object.x > 1000 or object.x < -300
		if !object.wrapping
			@clouds.delete_at(0)
			puts "deleted cloud"
		else
			object.x = -200
		end
	end
end

# reads all of the keyframes for all sprites
def get_keyframes(object)
	keyframes = {
		# 0..4 indicates the frames. 0.x indicates anim speed
		:right => Animation.new(object.frames[0..object.frames.length], 0.4),
		:left => Animation.new(object.frames[0..object.frames.length], 0.4)
	}
	return keyframes
end

def draw_obj(object, direction)
	if object.frames
		keyframes = get_keyframes(object)
		keyframes[direction].start.draw(object.x, object.y, object.zaxis, object.scale , object.scale)
	end
end
