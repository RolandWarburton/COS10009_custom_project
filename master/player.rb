require 'gosu'
require './animation'

class Player

      def Player.spawn_player(x, y, sprite, w, h)
            frames = Gosu::Image.new(sprite, :tileable => true)
            Hook.new(x, y, frames)
      end

      class Hook
            def initialize(x, y, frames)

                  @frames = frames

                  @x, @y = x, y

                  # pick which animation frames to apply
                  @draw = {
                        # 0..4 indicates the frames. 0.x indicates anim speed
                        :right => Animation.new(@frames[0..1], 0.4),
                        :left => Animation.new(@frames[0..1], 0.4)
                  }

                  # which direction
                  @movement = {
                        :up => 4.0,
                        :down => -4.0,
                  }
                  end

                  def draw
                        @draw[@direction].draw(@x, @y, 1, scale_x = 0.3, scale_y = 0.3)
                  end

                  # def move(direction)
                  #       if direction == :right || direction == :left
                  #             @x += @movement[direction]
                  #       end
                  #       if direction == :up || direction == :down
                  #             @y += @movement[direction]
                  #
                  #       end
                  #       # set the direction so draw() has access
                  #       @direction = direction
                  #
                  #       # wrap at the end of the screen
                  #       if @x > 1000
                  #             @x = -200
                  #       end
                  # end

            # cloud debug
            def what_am_i
                  puts 'i am a player'
            end

            def debug
                  puts "x: #{@x} y: #{@y}"
            end
      # end cloud class
      end







            def Obs.spawn
                  def cloud
                        Obs.new
                  end

            end


            class Player
                  puts "hello"
                  def what_am_i
                        puts "world"
                  end
            end

end
