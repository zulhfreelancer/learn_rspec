module ContactMacros
	def contact_is_hidden(contact)
		expect(contact.hidden?).to be_truthy
	end

    def parse_json(response)
        JSON.parse(response.body)
    end
end
