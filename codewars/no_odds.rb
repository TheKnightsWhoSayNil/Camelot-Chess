def no_odds( values )
  no_odds =  []
  values.each_with_index do |value; index|
    if value % 2 == 0
    no_odds.push(value)
    end
  end
  return no_odds
end

#--- codewars solution
# def no_odds( values )
#  values.select &:even?
# end

# def no_odds( values )
#  values.reject(&:odd?)
# end