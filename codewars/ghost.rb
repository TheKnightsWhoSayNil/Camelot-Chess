class Ghost
  def color
    color = ["white", "yellow", "red", "purple"]
    @color = color.sample  
  end
end


ghost = Ghost.new
puts ghost.color

# --- codewars
# class Ghost
#  def color
#    %w(white yellow purple red).sample
#  end
# end