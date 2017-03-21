def multiply(a,b)
  raise ArgumentError, 'arguments must be a numbers' unless a.is_a?(Integer) and b.is_a?(Integer)
  a*b
end