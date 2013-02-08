require 'spec_helper'

describe UserMailer do

  before(:each) { reset_mailer }

  describe "welcome deliver" do
    let(:user) { FactoryGirl.create(:user)  }
    let(:mail) { UserMailer.welcome(user) } # this only creates email

    it "send user welcome and signin url" do
      mail.subject.should eq("Hi! #{user.name}")
      mail.to.should eq(["rails@bgrantez.me"])
      mail.from.should eq(["no-reply@bgrantez.me"])
      mail.return_path.should eq("rails@bgrantez.me")
    end

    shared_examples_for "welcome email content" do
      it "has some content" do
        part.should include("Welcome to example.com, #{user.name}")
        part.should include("Hi! #{user.name}")
        part.should include("your username is: #{user.email}")
        part.should include("follow this link: #{signin_url}")
        part.should include("Thanks")
      end
    end

    it_behaves_like "multipart email"

    describe "text version" do
      it_behaves_like "welcome email content" do
        let(:part) { get_message_part(mail, /plain/) }
      end
    end

    describe "html version" do
      it_behaves_like "welcome email content" do
        let(:part) { get_message_part(mail, /html/) }
      end
    end

    it "should be sent" do
      # actually must be send
      mail.deliver
      ActionMailer::Base.deliveries.empty?.should be_false
      ActionMailer::Base.deliveries.last.to.should == mail.to#user.email
    end
  end

  describe "password resets deliver" do
    let(:user) { FactoryGirl.create(:user)  }
    let(:mail) { UserMailer.send_password_reset(user) } # this only creates email

    it "send user password reset and password_reset url" do
      mail.subject.should eq("Password reset notification for #{user.name}")
      mail.to.should eq(["rails@bgrantez.me"])
      mail.from.should eq(["no-reply@bgrantez.me"])
      mail.return_path.should eq("rails@bgrantez.me")
    end

    shared_examples_for "password reset email content" do
      it "has some content" do
        part.should include("Password reset notification!")
        part.should include("Hi! #{user.name}")
        part.should include("We have receive a password reset request. To reset your password, click the URL below between the next 2 hours.")
        part.should include("Click or copy and paste this link in your browser: #{edit_password_reset_url(user.remember_token)}")
        part.should include("If you did not request your password to be reset, just ignore this email and your password will continue to stay the same.")
        part.should include("Have a great day!")
      end
    end

    it_behaves_like "multipart email"

    describe "text version" do
      it_behaves_like "password reset email content" do
        let(:part) { get_message_part(mail, /plain/) }
      end
    end

    describe "html version" do
      it_behaves_like "password reset email content" do
        let(:part) { get_message_part(mail, /html/) }
      end
    end

    it "should be sent" do
      # actually must be send
      mail.deliver
      ActionMailer::Base.deliveries.empty?.should be_false
      ActionMailer::Base.deliveries.last.to.should == mail.to#user.email
    end
  end


  describe "password change deliver" do
    let(:user) { FactoryGirl.create(:user)  }
    let(:mail) { UserMailer.password_changed(user) } # this only creates email

    it "send user password change and password_reset url" do
      mail.subject.should eq("Your password has been changed!")
      mail.to.should eq(["rails@bgrantez.me"])
      mail.from.should eq(["no-reply@bgrantez.me"])
      mail.return_path.should eq("rails@bgrantez.me")
    end

    shared_examples_for "password change email content" do
      it "has some content" do
        part.should include("Password change notification!")
        part.should include("Hi! #{user.name}")
        part.should include("We have succesfully change your password.")
        part.should include("If you believe you have received this email in error, or that an unauthorized person has accessed your account, please go to #{new_password_reset_url} to reset your password immediately.")
        part.should include("Thanks!")
      end
    end

    it_behaves_like "multipart email"

    describe "text version" do
      it_behaves_like "password change email content" do
        let(:part) { get_message_part(mail, /plain/) }
      end
    end

    describe "html version" do
      it_behaves_like "password change email content" do
        let(:part) { get_message_part(mail, /html/) }
      end
    end

    it "should be sent" do
      # actually must be send
      mail.deliver
      ActionMailer::Base.deliveries.empty?.should be_false
      ActionMailer::Base.deliveries.last.to.should == mail.to#user.email
    end
  end

end