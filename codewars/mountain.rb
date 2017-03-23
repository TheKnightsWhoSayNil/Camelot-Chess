class Mountain
 
 attr_reader :name, :height
  
  def initialize(name, height)
    @name = name
    @height = height
  end

  # option - attr_reader not neccessary
  # def output_mountain
  #  puts "#{@name}, height: #{@height}m"
  # end
end

mountain = Mountain.new("The Matterhorn" , 4478)
puts "#{mountain.name}, height: #{mountain.height}m."

# option attr_reader not neccessary
# mountain.output_mountain
