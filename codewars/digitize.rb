def digitize(n)
if n > 0
total = []
else
total = [0]
end
    while n > 0 do
    modulus = n % 10
    total.push(modulus)
    n = (n - modulus) / 10
    end
    return total.reverse
  end

  puts digitize(123)

#--- codewars solution

#  def digitize(n)
#  n.to_s.chars.map(&:to_i)
# end

# def digitize(n)
#  n.to_s.split("").map(&:to_i)
# end