module ContactMacros
	def contact_is_hidden(contact)
		expect(contact.hidden?).to be_truthy
	end
end
