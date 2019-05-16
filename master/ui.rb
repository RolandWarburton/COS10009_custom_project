
def generate_fuel()
      fuel = Array.new()
      x = 1
      y = 5
      25.times do |i|
            fuel << spawn_obj(x, y, './media/fuel.png', 13, 36, 0, 0, 2, 0, false)
            x +=28
      end
      return fuel
end

def addfuel()
      # p @fuel
      loop do
            break if @fuelcells.size > 25
            @fuelcells << spawn_obj(@fuelcells[-1].x+28, 5, './media/fuel.png', 13, 36, 0, 0, 2, 0, false)
      end

end

def track_fuel(fuel)
      if @tracking < 0
            fuel.each do |f|
                  f.vely = 5
            end
      end

end
