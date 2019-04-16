require 'gosu'
require './animation'

class Cloud
      def initialize(x, y)
            @frames = Gosu::Image.load_tiles('cloud1.png', 846, 540)
            @x, @y = x, y

            @move = {
                  # 0..4 indicates the frames. 0.x indicates anim speed
                  :right => Animation.new(@frames[0..4], 0.4)
            }

            @movements = {
                  :right => 2.0
            }

            end

            #
            def draw
                  @move[:right].start.draw(@x, @y, 1, scale_x = 0.3, scale_y = 0.3)
            end

            def move(direction)
                  @x += @movements[direction]
                  # wrap at the end of the screen
                  @x %= 640
            end
      end
