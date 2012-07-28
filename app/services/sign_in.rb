module SignIn
  def sign_in(user)
    create_cookie(user.id, user.salt)
    @current_user = user 
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= from_remember_token
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    delete_cookie
    @current_user = nil
  end
end
