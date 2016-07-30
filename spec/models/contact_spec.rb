require 'rails_helper'

describe Contact do
	it "is valid with a firstname, lastname and email" do
		contact = Contact.new(
								firstname: "Zulhilmi",
								lastname: "Zainudin",
								email: "zulh@hellogold.com"
							 )
		expect(contact).to be_valid
	end
	
	it "is invalid without a firstname" do
		contact = Contact.new(firstname: nil)
		contact.valid?
		expect(contact.errors[:firstname]).to include("can't be blank")
	end

	it "is invalid without a lastname" do
		contact = Contact.new(lastname: nil)
		contact.valid?
		expect(contact.errors[:lastname]).to include("can't be blank")
	end

	it "is invalid without an email address" do
		contact = Contact.new(email: nil)
		contact.valid?
		expect(contact.errors[:email]).to include("can't be blank")
	end

	it "is invalid with a duplicate email address" do
		Contact.create(firstname: "John", lastname: "Doe", email: "john@example.com")
		contact = Contact.new(
								firstname: "John",
								lastname: "Doh",
								email: "john@example.com"
							 )
		contact.valid?
		expect(contact.errors[:email]).to include("has already been taken")
	end

	it "returns a contact's full name as a string" do
		contact = Contact.new(
								firstname: "John",
								lastname: "Doe",
								email: "john@example.com"
							 )
		expect(contact.name).to eq "John Doe"
	end

	describe "filter last name by letter" do
		before :each do
			@smith 	 = Contact.create(firstname: 'John', lastname: 'Smith', email: 'jsmith@example.com')
			@jones 	 = Contact.create(firstname: 'Tim', lastname: 'Jones', email: 'tj@example.com')
			@johnson = Contact.create(firstname: 'John', lastname: 'Johnson', email: 'jj@example.com')
		end

		context "matching letters" do
			it "returns a SORTED array of results that match" do
				# note we’re testing both the results of the query and the sort order;
				# jones will be retrieved from the database first but since we’re sorting by
				# last name then johnson should be stored first in the query results
				expect(Contact.by_letter('J')).to eq [@johnson, @jones]
			end
		end

		context "non-matching letters" do
			it "omits results that do not match" do
				expect(Contact.by_letter('J')).not_to include @smith
			end
		end
	end
end
