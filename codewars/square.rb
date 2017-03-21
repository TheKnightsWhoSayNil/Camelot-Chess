def squareSum(numbers)
 square = 0
 numbers.each do |number|
 square = square + number **2
 end
 return square
end

#--- codewars
# def squareSum(numbers)
#  numbers.map {|n| n*n}.reduce(:+)
# end

# def squareSum(numbers)
#  numbers.reduce { |s, n| s+=n**2 }
# end