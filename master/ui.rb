
# ===============================================================
# FUEL SYSTEM ===================================================
# ===============================================================
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
	loop do
		break if @fuelcells.size > 25
		@fuelcells << spawn_obj(@fuelcells[-1].x+28, 5, './media/fuel.png', 13, 36, 0, 0, 2, 0, false)
	end

end

def track_fuel(fuel)
	if @tracking < 0 then fuel.each { |f| f.vely = 5 } end
end

# ===============================================================
# SCORE SYSTEM ===================================================
# ===============================================================
def track_score(score)
	if @tracking < 0 then score.each { |s| s.vely = 5 } end
end
