module SessionsHelper
  include SignIn

  def create_cookie(user_id, user_salt)
    cookies.permanent.signed[:remember_token] = [user_id, user_salt]
  end

  def delete_cookie
    cookies.delete(:remember_token)
  end

  def from_remember_token
    AuthenticateUser.authenticate_with_salt(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end
end
