
def calc_mean(ary)
  if !ary.is_a?(Array)
    0
  elsif ary.empty?
    0
  else
    count = 0
    ary.each do |number|
    count += number
    end
    count = count / ary.length
  end
end

# --- codewars
# def calc_mean(ary)
#  ary.reduce(:+)/ary.size rescue 0
# end

# def calc_mean(ary)
#  (ary.inject(:+) / ary.length) rescue 0
# end

# def calc_mean(ary)
#  ary.inject(:+) / ary.size.to_f rescue 0
# end

# def calc_mean(ary)
#  ary.reduce(:+) / ary.length.to_f rescue 0
# end