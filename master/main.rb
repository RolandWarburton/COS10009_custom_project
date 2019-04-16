require 'gosu'
# require './cloud'
require './object'
# require './player'

class GameWindow < Gosu::Window
      def initialize
            super 1000, 500
            self.caption = "Game"

            # takes spawn_x, spawn_y, source, width, height
            # @cloud = Obs.new(0, 240, './media/cloud1.png', 846, 540)

            @cloud2 = Obs.spawn_cloud(0, 240, './media/cloud1.png', 846, 540)
            @cloud2.what_am_i

            # @player = Obs.spawn_player(100, 240, './media/hook.png', 600, 668)


            # @rod = Player.new(200, 200, './media/rod.png', 600, 668)

            @key = {
                  kb_left: Gosu::KbLeft,
                  kb_right: Gosu::KbRight,
            }

            @obj_types = {
                  # :cloud =>
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
            # direction
            @cloud2.update(:right)
            # puts @cloud2.debug

            # generic player movement
            # if Gosu::button_down? @key[:kb_left]
            #       @player.move(:left)
            # end
      end

      #draw
      def draw
            @cloud2.draw
            # @player.draw
      end

end


GameWindow.new.show
