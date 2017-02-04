require 'capybara/rspec'
require 'capybara/webkit/matchers'
Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.include(Capybara::Webkit::RspecMatchers, :type => :feature)

  config.after(:each) do
    # remove everything inside /spec/support/uploads folder
    # setup guide - http://bit.ly/2l6jxxC
    if Rails.env.test? || Rails.env.cucumber?
      FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads/*"])
    end 
  end
end
