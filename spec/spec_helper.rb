require 'capybara/rspec'
require 'capybara/webkit/matchers'
Capybara.javascript_driver = :webkit

RSpec.configure do |config|

end

RSpec.configure do |config|
  config.include(Capybara::Webkit::RspecMatchers, :type => :feature)
end
