require_relative "./password_encryption"

class SignUp
  def initialize(encryptor=PasswordEncryption)
    @encryptor = encryptor
  end

  def sign_up(user)
    return false if !user.valid?
    user.salt = @encryptor.make_salt(user.password) if user.new_record?
    user.encrypted_password = @encryptor.encrypt("#{user.salt}--#{user.password}") 
    user.save && true
  end
end

class UpdateUserInfo
  def self.update_info(user)
    SignUp.new.sign_up(user)
  end
end
