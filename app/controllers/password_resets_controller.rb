class PasswordResetsController < ApplicationController

  def new
  end

  def edit
    @user = User.find_by_remember_token!(params[:id])
  end

  def create
    if !params[:email].blank?
      user = User.find_by_email(params[:email])
    end
    if user
      user.set_password_reset
      if user.save!
        UserMailer.send_password_reset(user).deliver
      end
      redirect_to root_url, :notice => 'Email sent with password reset instructions.'
    else 
      redirect_to root_url
    end
  end

  def update
    @user = User.find_by_remember_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      UserMailer.password_changed(@user).deliver
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end
end
