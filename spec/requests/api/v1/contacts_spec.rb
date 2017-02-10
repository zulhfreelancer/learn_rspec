require 'rails_helper'

describe "Contacts API", type: :request do
    
    it "get a contact" do
        contact = FactoryGirl.create(:contact)

        # nil means no parameters
        get "/api/v1/contacts/#{contact.id}.json", nil, {}
        expect(response).to have_http_status(:success)

        json = parse_json(response)
        expect(json['firstname']).to eq(contact.firstname)
        expect(json['lastname']).to eq(contact.lastname)
        expect(json['email']).to eq(contact.email)
    end

    it "update a contact" do
        contact = FactoryGirl.create(:contact)
        new_attributes = {
            contact: {
                firstname: "New",
                lastname:  "Name",
                email:     "new@name.com"
            }
        }

        put "/api/v1/contacts/#{contact.id}.json", new_attributes, {}
        expect(response).to be_success

        json = parse_json(response)
        expect(json['firstname']).to eq("New")
        expect(json['lastname']).to eq("Name")
        expect(json['email']).to eq("new@name.com")
    end

end
