require 'gosu'

class Animation
      def initialize(frames, time_in_secs)
            @frames = frames
            @time = time_in_secs * 1000
      end

      def start(*frame)
            frame.size > 0 ? @frames[0] :  @frames[Gosu::milliseconds / @time % @frames.size]
      end

      def stop
            @frames[0]
      end
end
