require 'gosu'
require './animation'

class Obj
	attr_accessor :x, :y, :w, :h, :tiles, :keyframes, :scale, :zaxis, :wrapping, :velx, :vely, :spritesheet
	def initialize(x, y, spritesheet, w, h, velx, vely, scale, zaxis, wrapping)
		@x, @y = x, y
		@h, @w = h, w
		@spritesheet = spritesheet
		# p spritesheet
		@velx = velx
		@vely = vely
		@scale = scale
		@zaxis = zaxis
		@wrapping = wrapping
		@tiles = Gosu::Image.load_tiles(spritesheet, w, h)
		# instance a new animation
		@keyframes = get_keyframes(self)
	end
end

# TODO: add cell/tile type to object class to identify it for animation in draw_blocks()
def spawn_obj(x, y, spritesheet, w, h, velx, vely, scale, zaxis, wrapping)
	# puts "spawning object #{spritesheet}"
	Obj.new(x, y, spritesheet, w, h, velx, vely, scale, zaxis, wrapping)
end

# reads all of the keyframes for all sprites of a particular object
def get_keyframes(object)
	# object.tiles.length > 0 ? (last_frame = object.tiles.length) : (last_frame = 1)
	if object.tiles.length > 0
		keyframes = {
			:first => Animation.new(object.tiles[0..0], 0.4),
			:last => Animation.new(object.tiles[object.tiles.length-1..object.tiles.length], 0.4),
			:anim => Animation.new(object.tiles[0..object.tiles.length-1], 0.4)
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

def teleport_object(object, x, y)
	object.x = x
	object.y = y
end

def floor_coord(x,y)
	return [x > 0 ? x : 0, y > 0 ? y : 0]
end

# return an objects location on the grid
def get_grid_loc(object)
	x = (object.x.floor_to(50))/CELL_DIM
	y = (object.y.floor_to(50))/CELL_DIM
	return [x,y]
end

# translates a pixel location to a grid location
def pix_round(object)
	x = object.x(50)
	y = object.y(50)
	return [x, y]
end

# determines if an object needs to wrap the screen
def process_boundaries(object)
	if object.x > (@cell_y_count*CELL_DIM)-CELL_DIM
		teleport_object(@player, (@cell_y_count*CELL_DIM)-CELL_DIM, @player.y)
		object.target_location = get_grid_loc(@player)
		return false
	elsif object.x < 0
		teleport_object(@player, 0, @player.y)
		object.target_location = get_grid_loc(@player)
		return false
	end
	return true

end

# how can i do this as a ruby optional argument?
def draw_obj(object, direction=:right)
	if object then object.keyframes[direction].start().draw(object.x, object.y, object.zaxis, object.scale , object.scale) end
end
