
def unique(integers)
  n = 0 
  while n < integers.length - 1 do
    m = n + 1
    while m < integers.length do
      if integers[n] == integers[m]
         integers.delete_at(m)
      else m += 1 
      end
    end
    n = n + 1
  end
end
 
input = [];
puts "Write values separated by enter, when finished write - end:"
loop do
  item = gets.chomp
  break if item == 'end'  
  input.push(item)
end

puts "The array is #{input}."
puts "The array has got #{input.count} items."

 unique_array = unique(input)
 puts "The unique_array is #{input}."
 puts "The unique_array has got #{input.count} items."

 
#--- codewars solution

# def unique(integers)
#  integers & integers
# end

# def unique(integers)
# new=[]
# integers.each {|x| new.push(x) unless new.include?(x) }
# new
# end
