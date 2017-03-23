def sum(numbers)
  count = 0
  numbers.each do |number|
    count += number
  end
  
  return count
end

# or a really shorthand way its to make use of Ruby’s map method on Arrays like so;

def sum(numbers)
  numbers.inject(&:+)
end

def sum(numbers)
  numbers.inject(0, :+)
end

def sum(numbers)
  numbers.reduce(0, :+)
end