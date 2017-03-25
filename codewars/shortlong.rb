def solution(a, b)
  array =  []
  array.push(a, b)
  if array[0].length > array[1].length
  array.unshift(array[1]).join
  else array.push(array[0]).join
  end
end

# ---codewars solution

#def solution(a, b)
 # a.length < b. length ? a + b + a : b + a + b 
# end


# def solution(a, b)
#  a<b ? a+b+a : b+a+b
# end