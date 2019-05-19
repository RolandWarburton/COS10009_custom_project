
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
		@fuelcells << spawn_obj(@fuelcells[-1].x+28, @fuelcells[-1].y, './media/fuel.png', 13, 36, 0, 0, 2, 0, false)
	end

end

def track_fuel(fuel)
	if @tracking < 0 then fuel.each { |f| f.vely = @screen_scroll_speed } end
end

# ===============================================================
# SCORE SYSTEM ===================================================
# ===============================================================
def track_scorebox()
	if @tracking < 0 then @scorebox.vely = @screen_scroll_speed; @total_score.vely = @screen_scroll_speed end
end
