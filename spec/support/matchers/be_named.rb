RSpec::Matchers.define :be_named do |expected|
	match do |actual|
		expect(actual.name).to eq(expected)
	end

	description do
		'return a full name as string'
	end
end
