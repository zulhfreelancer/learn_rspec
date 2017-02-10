class Api::V1::ContactsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_contact

    def show
        render :json => { firstname: @contact.firstname, lastname: @contact.lastname, \
            email: @contact.email }
    end

    def update
        @contact.update(contact_params)
        show # call show method above
    end

    private

    def set_contact
        @contact = Contact.find(params[:id])
    end

    def contact_params
        params.require(:contact).permit(:firstname, :lastname, :email)
    end
    
end
