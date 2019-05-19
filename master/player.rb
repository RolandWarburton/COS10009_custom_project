require 'gosu'
require './animation'

class Player < Obj
      attr_accessor :location, :target_location, :speed, :alive
end

def spawn_player(x=0, y=0, spritesheet='./media/dirt.png', w=100, h=100, velx=0, vely=0, scale=1, zaxis=1, wrapping=false)
	Player.new(x, y, spritesheet, w, h, velx, vely, scale, zaxis, wrapping)
end
