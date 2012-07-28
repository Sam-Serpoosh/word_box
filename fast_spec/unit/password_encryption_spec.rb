require_relative "../spec_helper_lite"
require_relative_to_root "app/services/password_encryption"

module Digest
  class SHA2
  end
end

describe PasswordEncryption do
  let(:encryptor) { PasswordEncryption }

  it "creates salt with given string and time combination" do
    str = "any string"
    utc_time = "now-utc"
    secured_salt = "secured_salt"
    time = stub(:now => stub(:utc => utc_time)) 
    digest_mock("#{utc_time}--#{str}", secured_salt)
    salt = encryptor.make_salt(str, time)
    salt.should == secured_salt 
  end
  
  it "encrypts given password" do
    password = "password"
    encrypted_password = "encrypted password"
    digest_mock(password, encrypted_password)
    encrypted = encryptor.encrypt(password)
    encrypted.should == encrypted_password 
  end

  def digest_mock(expected_argument, return_value)
    Digest::SHA2.should_receive(:hexdigest).with(expected_argument).
      and_return(return_value)
  end
end
