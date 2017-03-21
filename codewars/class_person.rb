class Person
  attr_reader :age
  def initialize(firstName, lastName, age)
    @firstName = firstName
    @lastName = lastName
    @age = age
  end
  
  def full_name
    "#{@firstName} #{@lastName}"
  end   
end

person = Person.new('Yukihiro', 'Matsumoto', 47)
puts person.full_name
puts person.age