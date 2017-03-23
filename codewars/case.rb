def get_planet_name(id)
  # This doesn't work; Fix it!
  case id
    when 1 then puts "Mercury"
    when 2 then puts "Venus"
    when 3 then puts "Earth"
    when 4 then puts "Mars"
    when 5 then puts "Jupiter"
    when 6 then puts "Saturn"
    when 7 then puts "Uranus"  
    when 8 then puts "Neptune"
  end
end

get_planet_name(1)