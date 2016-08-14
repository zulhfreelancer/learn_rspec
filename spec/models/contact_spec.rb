require 'rails_helper'

describe Contact do
	it "has a valid factory" do
		expect(build(:contact)).to be_valid
	end

	it "has three phone numbers" do
		contact = create(:contact)
		expect(contact.phones.count).to eq 3
	end

	it "is valid with a firstname, lastname and email" do
		contact = create(:contact)
		expect(contact).to be_valid
	end
	
	it "is invalid without a firstname" do
		contact = build(:contact, firstname: nil)
		contact.valid?
		expect(contact.errors[:firstname]).to include("can't be blank")
	end

	it "is invalid without a lastname" do
		contact = build(:contact, lastname: nil)
		contact.valid?
		expect(contact.errors[:lastname]).to include("can't be blank")
	end

	it "is invalid without an email address" do
		contact = build(:contact, email: nil)
		contact.valid?
		expect(contact.errors[:email]).to include("can't be blank")
	end

	it "is invalid with a duplicate email address" do
		create(:contact, email: "john@example.com")
		contact = build(:contact,
								firstname: "John",
								lastname: "Doh",
								email: "john@example.com"
							 )
		contact.valid?
		expect(contact.errors[:email]).to include("has already been taken")
	end

	it "returns a contact's full name as a string" do
		contact = build(:contact,
								firstname: "John",
								lastname: "Doe",
								email: "john@example.com"
							 )
		expect(contact.name).to eq "John Doe"
	end

	describe "filter last name by letter" do
		before :each do
			@smith 	 = create(:contact, lastname: 'Smith')
			@jones 	 = create(:contact, lastname: 'Jones')
			@johnson = create(:contact, lastname: 'Johnson')
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
