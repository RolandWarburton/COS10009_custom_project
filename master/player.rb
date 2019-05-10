require 'gosu'
require './animation'

class Player < Obj
      attr_accessor :location, :target_location
end

def spawn_player(x=0, y=0, spritesheet='./media/dirt.png', w=100, h=100, velx=0, vely=0, scale=1, zaxis=1, wrapping=false)
	# puts "spawning object #{spritesheet}"
	tiles = Gosu::Image.load_tiles(spritesheet, w, h)
	Player.new(x, y, tiles, w, h, velx, vely, scale, zaxis, wrapping)
end
