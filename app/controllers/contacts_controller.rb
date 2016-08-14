class ContactsController < ApplicationController
  # before_action :authenticate, except: [:index, :show]
  before_action :set_contact, only: [:show, :edit, :update, :destroy, :hide]

  # GET /contacts
  # GET /contacts.json
  def index
    if params[:letter]
      @contacts = Contact.by_letter(params[:letter])
    else
      @contacts = Contact.order('lastname, firstname')

      respond_to do |format|
        format.html # index.html.erb
        format.csv { 
          response.headers['Content-Type'] = 'text/csv'
          send_data @contacts.to_csv 
        }
      end
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    %w(home office mobile).each do |phone|
      @contact.phones.build(phone_type: phone)
    end
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH /contacts/1/hide
  def hide
    @contact.hide
    redirect_to @contact
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:firstname, :lastname, :email,
        :phones_attributes => [:id, :phone, :phone_type])
    end
end
