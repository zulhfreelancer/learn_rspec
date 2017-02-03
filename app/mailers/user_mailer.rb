class UserMailer < ApplicationMailer
  def welcome(email)
    @greeting = "Hi there!"
    mail to:       "User Name <#{email}>", \
         subject:  "Welcome to MyApp!", \
         reply_to: "Support <support@app.com>"
  end
end
