class AuthenticateUser
  def initialize(encryptor = PasswordEncryption)
    @encryptor = encryptor
  end

  def authenticate(email, submitted_password)
    user = User.find_by_email(email)
    return nil if user.nil?
    authenticated = user.encrypted_password == @encryptor.encrypt("#{user.salt}--#{submitted_password}")
    authenticated ? user : nil
  end

  def self.authenticate_with_salt(id, salt)
    user = User.find_by_id(id)
    (user && user.salt == salt) ? user : nil
  end
end
