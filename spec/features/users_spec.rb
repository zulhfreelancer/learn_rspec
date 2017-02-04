require 'rails_helper'

feature 'User management' do
	scenario 'adds a new user', :js => true do
		admin = create(:admin) # <-- the first user
		sign_in(admin) # calling LoginMacros

		visit root_path
		click_link 'Users'
		click_link 'New User'
		fill_in 'Email', with: 'new_user@example.com'
		find('#password').fill_in 'Password', with: 'secret123'
		find('#password_confirmation').fill_in 'Password confirmation', with: 'secret123'
		attach_file 'user[avatar]', File.join(Rails.root, 'spec', 'factories', 'avatar.png')
		click_button 'Create User'

		# this will open the result in browser using 'launchy' gem
		# save_and_open_page

		# entering second page (users#index)
		expect(current_path).to eq(users_path)
		expect(page).to have_content('New user created')

		# at this point, we already in second page (users#index)
		# since `wait_until` method was removed in latest Capybara
		# we need to 'listen' the second page is loaded first (2 lines above)
		# because having a form and attachment (avatar) will make Capybara
		# behave like a real user interaction (fill-in form -> upload -> wait -> get redirected)
		# if we not wait for second page to finish loading, we can't really test this
		expect(User.count).to eq(2)

		within('h1') { expect(page).to have_content('Users') }
		expect(page).to have_content('new_user@example.com')
	end
end
