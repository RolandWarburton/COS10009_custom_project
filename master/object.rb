require 'gosu'
require './animation'

class Obs

      def Obs.spawn_player(x, y, sprite, w, h)
            Player.new(Gosu::Image.new(sprite, :tileable => true))
      end

      def Obs.spawn_cloud(x, y, sprite, w, h)
            frames = Gosu::Image.load_tiles(sprite, w, h)
            Cloud.new(x, y, frames)
      end

      class Cloud

            def initialize(x, y, frames)

                  @frames = frames
                  @x, @y = x, y

                  # pick which animation frames to apply
                  @animate = {
                        # 0..4 indicates the frames. 0.x indicates anim speed
                        :right => Animation.new(@frames[0..4], 0.4),
                        :left => Animation.new(@frames[0..4], 0.4)
                  }

                  # which direction
                  @movement = {
                        :left => -4.0,
                        :right => 4.0,
                        :stop => 0.0
                  }
            end

            def update(direction)
                  # moves the object
                  move(direction)
                  # set the direction so draw() has access
                  @direction = direction
                  # wrap at the end of the screen
                  if @x > 1000
                        @x = -200
                  end
            end

            def draw
                  @animate[@direction].start.draw(@x, @y, 1, scale_x = 0.3, scale_y = 0.3)
            end

            # cloud debug
            def what_am_i
                  puts 'i am a cloud'
            end

            def debug
                  puts "x: #{@x} y: #{@y}"
            end
      # end cloud class
      end


      # class Player
      #       def initialize(sprite)
      #             @sprite = sprite
      #             @x, @y = 100, 200
      #       end
      #
      #       def draw
      #             @sprite.draw(@x, @y, 1, scale_x = 0.05, scale_y = 0.05)
      #       end
      #
      #       puts "hello"
      #       def what_am_i
      #             puts "world"
      #       end
      # end

            # def Obs.spawn
            #       def cloud
            #             Obs.new
            #       end
            #
            # end
            #
            #
            # class Player
            #       puts "hello"
            #       def what_am_i
            #             puts "world"
            #       end
            # end


end

def move(direction)
      if direction == :right || direction == :left
            @x += @movement[direction]
      end

      if direction == :up || direction == :down
            @y += @movement[direction]
      end

      if direction == :stop
            @x = 0
            @y = 0
      end

end
