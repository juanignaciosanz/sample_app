require 'spec_helper'

describe "PasswordResets" do

  subject { page }

  describe "new password reset page" do
    before { visit new_password_reset_path }

    it { should have_selector('h1',    text: 'Reset password') }
    it { should have_selector('title', text: full_title('Reset password')) }
  end

  describe "request reset password" do

    before { visit new_password_reset_path }

    let(:submit) { "Reset password" }

    describe "with invalid information" do
      describe "after submission" do
        before { click_button submit }

        it { should_not have_selector('div.alert.alert-notice', text: 'Email sent with password reset instructions.') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email
        click_button submit
      end

      specify { user.password_reset_sent_at.should == nil }
      specify { user.reload.password_reset_sent_at.should_not == nil }

      describe "after resetting the password" do
        it { should have_selector('div.alert.alert-notice', text: 'Email sent with password reset instructions.') }
      end
    end
  end

  describe "change password page" do
    let(:user) { FactoryGirl.create(:user) }
    before do 
      visit edit_password_reset_path(user.remember_token) 
    end

    it { should have_selector('h1',    text: 'Update password') }
    it { should have_selector('title', text: full_title('Update password')) }
  end

  describe "when changing password" do
    let(:reset) { FactoryGirl.create(:password_reset) }
    before do
      visit edit_password_reset_path(reset.remember_token) 
    end

    let(:submit) { "Update password" }

    describe "with invalid information" do
      describe "after submission" do
        before { click_button submit }

        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in "Password", with: 'foobar' }
      before { fill_in "Password confirmation", with: 'foobar' }

      describe "after resetting the password" do
        before { click_button submit }

        it { should have_selector('div.alert.alert-notice', text: 'Password has been reset!') }
      end
    end
  end

end
