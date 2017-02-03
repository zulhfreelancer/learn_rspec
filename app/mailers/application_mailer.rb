class ApplicationMailer < ActionMailer::Base
  default from: "MyApp <my@app.com>"
  layout 'mailer'
end
