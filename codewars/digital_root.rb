def digital_root(n)
  total = 0
    while n > 0 do
    modulus = n % 10
      if modulus > 0
    total = total + modulus
    n = (n - modulus) / 10
      else n = n / 10
      end
   end
 if total >= 10
  digital_root(total)
  else
   return total
 end
end
puts "Enter an integer:"
n = gets.chomp.to_i
puts digital_root(n)
