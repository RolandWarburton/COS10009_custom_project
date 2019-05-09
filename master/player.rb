require 'gosu'
require './animation'

class Player

      def Player.spawn_player(x, y, sprite, w, h)
            sprite = Gosu::Image.new(sprite, :tileable => true)
            Player.new(x, y, w, h, sprite)
      end

      class Player
		def initialize(x, y, w, h, sprite)
			@x, @y, @w, @h = x, y, w, h
			@image = sprite
		end

		def draw
			draw_image(@image, @x, @y)
		end

      end
      # end player class
end
