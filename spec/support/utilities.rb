include ApplicationHelper
def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

def last_email
  ActionMailer::Base.deliveries.last
end

def reset_mailer
  ActionMailer::Base.deliveries = []
end

def get_message_part (mail, content_type)
  mail.body.parts.find { |p| p.content_type.match content_type }.body.raw_source
end

shared_examples_for "multipart email" do
  it "generates a multipart message (plain text and html)" do
    mail.body.parts.length.should eq(2)
    mail.body.parts.collect(&:content_type).should == ["text/plain; charset=UTF-8", "text/html; charset=UTF-8"]
  end
end



