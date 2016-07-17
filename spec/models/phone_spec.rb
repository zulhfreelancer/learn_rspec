require 'rails_helper'

describe Phone do
	it "does not allow duplicate phone numbers per contact" do
		contact = Contact.create(
									firstname: "John",
									lastname: "Doh",
									email: "john@example.com"
							 	)
		contact.phones.create(
								phone_type: 'home',
								phone: '0123456789'
							 )
		mobile_phone = contact.phones.new(
											phone_type: 'mobile',
											phone: '0123456789'				
										 )
		mobile_phone.valid?
		expect(mobile_phone.errors[:phone]).to include('has already been taken') 
	end

	it "allows two contacts to share a phone number" do
		first_contact = Contact.create(
										firstname: "John",
										lastname: "Doh",
										email: "john@example.com"
								 	  )
		first_contact.phones.create(
										phone_type: 'home',
										phone: '0123456789'
									)
		second_contact = Contact.new
		second_contact_phone = second_contact.phones.new(
															phone_type: 'home',
															phone: '0123456789'
														)
		expect(second_contact_phone).to be_valid
	end
end
