class UpdateUserInfo
  def initialize(signup = SignUp.new)
    @signup = signup
  end

  def update(user)
    @signup.sign_up(user)
  end
end
