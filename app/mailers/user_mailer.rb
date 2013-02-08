class UserMailer < ActionMailer::Base
  default from: "bGrantez Notifications <no-reply@bgrantez.me>",
          return_path: 'rails@bgrantez.me'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    @greeting = "Hi! #{@user.name}"
    mail to: "#{@user.name} <rails@bgrantez.me>", subject: @greeting
  end
  
  def send_password_reset(user)
    @user = user
    @greeting = "Password reset notification for #{@user.name}"
    mail to: "#{@user.name} <rails@bgrantez.me>", subject: @greeting
  end
  
  def password_changed(user)
    @user = user
    @greeting = "Your password has been changed!"
    mail to: "#{@user.name} <rails@bgrantez.me>", subject: @greeting
  end
end
