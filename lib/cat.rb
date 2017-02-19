class Cat
	def initialize(name, age)
		@name = name
		@age  = age
	end

	def name
		@name
	end

	def age
		@age
	end

	def describe
		"#{@name} is #{@age} years old."
	end
end

# c = Cat.new("Tom", 3)
# puts c.name
# puts c.age
# puts c.describe
