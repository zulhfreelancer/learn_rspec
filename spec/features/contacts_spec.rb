require 'rails_helper'

feature 'Contacts feature' do
	it "wishes the visitor a happy new year on Jan 1" do
		Timecop.travel(Time.parse("January 1"))
		visit root_path
		expect(page).to have_text("Happy new year!")
		Timecop.return
	end
	it "wishes the visitor 'Hello there!' on other days" do
		visit root_path
		expect(page).to have_text("Hello there!")
	end
end
