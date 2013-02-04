module SessionsHelper

  def sign_in(user)
    #cookies[:remember_token] = { value:   user.remember_token,
    #                             expires: 20.years.from_now.utc }
    # permanent is a shortcut for this duration
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def signed_in?
    !current_user.nil?
  end
end
