def nthterm(first, n, c)
  value = first
  n.times do
  value += c
  end
return value
end

puts nthterm(0,6,1)


# ---codewars solution
#def nthterm(first, n, c)
 # first + n*c
# end
