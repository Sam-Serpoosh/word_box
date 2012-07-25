require 'digest'

class PasswordEncryption
  def self.make_salt(str, time=Time)
    secure_hash("#{time.now.utc}--#{str}")
  end

  def self.encrypt(str)
    secure_hash(str) 
  end

  def self.secure_hash(str)
    Digest::SHA2.hexdigest(str)
  end
end
