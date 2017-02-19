FactoryGirl.define do
	
	factory :cat do
		name { "Oreo" }
        age  {   3    }

        # http://stackoverflow.com/a/12961116/1577357
        initialize_with { new(name, age) }
	end

end
