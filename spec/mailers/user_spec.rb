require "rails_helper"

RSpec.describe User, :type => :mailer do
  
  describe "Welcome Email" do  
    before(:all) do
      @email = UserMailer.welcome("john@doe.com")
    end

    it "should be delivered from my@app.com" do
      expect(@email).to be_delivered_from("MyApp <my@app.com>")
    end

    it "should have reply to support@app.com" do
      expect(@email).to have_reply_to("support@app.com")
    end

    it "should be set to be delivered to the email passed in" do

      expect(@email).to deliver_to("User Name <john@doe.com>")
    end

    it "should have the correct subject" do
      expect(@email).to have_subject(/Welcome/)
    end

    it "should contain the user's message in the mail body" do
      expect(@email).to have_body_text(/Hi/)
    end
  end

end
