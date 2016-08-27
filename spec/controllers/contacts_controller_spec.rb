require'rails_helper'

describe ContactsController do

	shared_examples "public access to contacts" do
		describe "GET #index" do
			context "with params[:letter]" do
				it "populates an array of contacts starting with the letter" do
					smith = create(:contact, lastname: 'Smith')
					jones = create(:contact, lastname: 'Jones')
					get :index, letter: 'S'
					expect(assigns(:contacts)).to match_array([smith])
				end
				it "renders the :index template" do
					get :index, letter: 'S'
					expect(response).to render_template :index
				end
			end

			context "without params[:letter]" do
				it "populate an array of all contacts" do
					smith = create(:contact, lastname: 'Smith')
					jones = create(:contact, lastname: 'Jones')
					get :index
					expect(assigns(:contacts)).to match_array([smith, jones])
				end
				it "renders the :index template" do
					get :index
					expect(response).to render_template :index
				end
			end
		end

		describe "GET #show" do
			it "assigns the requested contact to @contact" do
				contact = create(:contact)
				get :show, id: contact

				# variables instantiated by the controller method (@contact) can be evaluated using assigns(:contact)
				expect(assigns(:contact)).to eq contact
			end
			it "renders the :show template" do
				contact = create(:contact)
				get :show, id: contact
				expect(response).to render_template :show
			end
		end
	end # shared_examples

	shared_examples "full access to contacts" do
		before :each do
			set_user_session(create(:admin))
		end

		describe "GET #new" do
			it "assigns a new contact to @contact" do
				get :new
				expect(assigns(:contact)).to be_a_new(Contact)
			end
			it "renders the :new template" do
				get :new
				expect(response).to render_template :new
			end
		end

		describe "GET #edit" do
			it "assigns a new contact to @contact" do
				contact = create(:contact)
				get :edit, id: contact
				expect(assigns(:contact)).to eq contact
			end
			it "renders the :edit template" do
				contact = create(:contact)
				get :edit, id: contact
				expect(response).to render_template :edit
			end
		end

		describe "POST #create" do
			before :each do
				@phones = [
					attributes_for(:phone),
					attributes_for(:phone),
					attributes_for(:phone)
				]
			end

			context "with valid attributes" do
				it "saves the new contact in the database" do
					expect{
						post :create, contact: attributes_for(:contact, phones_attributes: @phones)
					}.to change(Contact, :count).by(1)
				end	
				it "redirects to contacts#show" do
					post :create, contact: attributes_for(:contact, phones_attributes: @phones)
					expect(response).to redirect_to contact_path(assigns[:contact])
				end
			end

			context "with invalid attributes" do
				it "does not save the new contact in the database" do
					expect{
						post :create, contact: attributes_for(:invalid_contact)
					}.not_to change(Contact, :count)
				end	
				it "renders the :new template" do
					post :create, contact: attributes_for(:invalid_contact)
					expect(response).to render_template :new
				end
			end
		end

		describe "PATCH #update" do
			before :each do
				@contact = create(:contact, firstname: 'John', lastname: 'Doe')
			end

			context "with valid attributes" do
				it "locates the requested @contact" do
					patch :update, id: @contact, contact: attributes_for(:contact)
					expect(assigns(:contact)).to eq(@contact)
				end	
				it "changes @contact's attributes" do
					patch :update, id: @contact, contact: attributes_for(:contact,
																		  firstname: 'Joe',
																		  lastname: 'Doe'
																		)
					@contact.reload
					expect(@contact.firstname).to eq('Joe')
					expect(@contact.lastname).to eq('Doe')
				end
				it "redirects to the updated contact" do
					patch :update, id: @contact, contact: attributes_for(:contact)
					expect(response).to redirect_to @contact
				end
			end

			context "with invalid attributes" do
				it "does not changes @contact's attributes" do
					patch :update, id: @contact, contact: attributes_for(:contact,
																		  firstname: 'Joe',
																		  lastname: nil
																		)
					@contact.reload
					expect(@contact.firstname).not_to eq('Joe') # because it's invalid, firstname still 'John'
					expect(@contact.lastname).to eq('Doe')
				end
				it "re-renders the :edit template" do
					patch :update, id: @contact, contact: attributes_for(:invalid_contact)
					expect(response).to render_template :edit
				end
			end
		end

		describe "DELETE #destroy" do
			before :each do
				@contact = create(:contact)
			end

			it "delete the contact from the database" do
				expect{
					delete :destroy, id: @contact
				}.to change(Contact, :count).by(-1)
			end
			it "redirects to users#index" do
				delete :destroy, id: @contact
				expect(response).to redirect_to contacts_url
			end
		end

		# ==================================================
		# non-CRUD methods
		# ==================================================

		describe "PATCH #hide" do
			before :each do
				@contact = create(:contact)
			end

			it "marks the contact as hidden" do
				patch :hide, id: @contact
				contact_is_hidden(@contact.reload)
			end

			it "redirects to contacts#show" do
				patch :hide, id: @contact
				expect(response).to redirect_to @contact
			end
		end
	end # full access to contacts

	describe "administrator access" do
		it_behaves_like "public access to contacts"
		it_behaves_like "full access to contacts"
	end

	describe "user access" do
		it_behaves_like "public access to contacts"
		it_behaves_like "full access to contacts"
	end

	# + redirect to login page
	describe "guest access" do
		it_behaves_like "public access to contacts"

		describe "GET #new" do
			it "requires login" do
				get :new
				expect(response).to require_login
			end
		end

		describe "GET #edit" do
			it "requires login" do
				contact = create(:contact)
				get :edit, id: contact
				expect(response).to require_login
			end
		end

		describe "POST #create" do
			it "requires login" do
				post :create, id: create(:contact), contact: attributes_for(:contact)
				expect(response).to require_login
			end
		end

		describe "PATCH #update" do
			it "requires login" do
				put :update, id: create(:contact), contact: attributes_for(:contact)
				expect(response).to require_login
			end
		end

		describe "DELETE #destroy" do
			it "requires login" do
				delete :update, id: create(:contact)
				expect(response).to require_login
			end
		end
	end

	# ==================================================
	# non-HTML output methods
	# ==================================================

	describe "CSV output" do
		it "returns a CSV file" do
			get :index, format: :csv
			expect(response.headers['Content-Type']).to match 'text/csv'
		end

		it "returns content" do
			create(:contact, firstname: 'John', lastname: 'Doe', email: 'johndoe@example.com')
			get :index, format: :csv
			csv_array = response.body.split(',')
			expect(csv_array).to include('John', 'Doe', 'johndoe@example.com')
		end
	end

end
