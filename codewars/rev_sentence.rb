def solution(sentence)
 words = sentence.scan(/\w+/)
 return words.reverse.join(" ")
end

def solution(sentence)
  return sentence.scan(/\w+/).reverse.join(" ")
end

def solution(sentence)
 str = ""
 words = sentence.scan(/\w+/)
 words.reverse_each { |word| str += "#{word} "}
 return str.strip
end

puts "Write a sentence which will be reversed:"
input = gets.chomp
puts solution(input)

#--- codewars solutions
# def solution(sentence)
# sentence.split.reverse.join(" ")
# end

# def solution(sentance)
#  sentance.split(' ').reverse.join(' ')
# end
