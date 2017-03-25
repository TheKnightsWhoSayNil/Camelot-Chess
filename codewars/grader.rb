def grader(score)
  if score >= 0.9 && score <= 1
  return "A"
  elsif score >= 0.8 && score < 0.9
  return "B"
   elsif score >= 0.7 && score < 0.8
  return "C"
   elsif score >= 0.6 && score < 0.7
  return "D"
else
  return "F"    
  end
end

puts grader(0.75)


# ---codewars solution
def grader(score)
  case score
    when 0.6...0.7 then "D"
    when 0.7...0.8 then "C"
    when 0.8...0.9 then "B"
    when 0.9..1 then "A"
    else "F"
  end
end