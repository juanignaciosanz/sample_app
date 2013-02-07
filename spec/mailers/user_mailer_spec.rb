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

    shared_examples_for "multipart email" do
      it "generates a multipart message (plain text and html)" do
        mail.body.parts.length.should eq(2)
        mail.body.parts.collect(&:content_type).should == ["text/plain; charset=UTF-8", "text/html; charset=UTF-8"]
      end
    end

    shared_examples_for "your email content" do
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
      it_behaves_like "your email content" do
        let(:part) { get_message_part(mail, /plain/) }
      end
    end

    describe "html version" do
      it_behaves_like "your email content" do
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