class Animal
  def eat
    puts "om nom nom nom nom"
  end
end

class Dog < Animal
  def bark
    puts "woof"
  end
end

class Cat < Animal
  def meow
    puts "meow"
  end
end

  class Duck < Animal
    def quack
      puts "quack"
    end
  end

  class GoldenRetriever < Dog
    def fetch
        puts "run and get"
      end
  end

  class Poodle < Dog

  end


animal = Animal.new
dog = Dog.new
cat = Cat.new
duck = Duck.new
gr = GoldenRetriever.new
pe = Poodle.new

puts animal.is_a?(Animal)
puts animal.is_a?(Poodle)
puts dog.is_a?(Animal)
puts dog.is_a?(GoldenRetriever)
puts gr.is_a?(GoldenRetriever)
puts gr.is_a?(Dog)