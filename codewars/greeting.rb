class Person
  attr_accessor :name, :other_name
  def initialize(name)
    @name = name
  end
  
  def greet(other_name)
    puts "Hi #{other_name}, my name is #{@name}"
  end
end

person = Person.new(:Bang)
person.greet(:Olufsen)


