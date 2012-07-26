require File.expand_path(File.dirname(__FILE__) + "/../app/services/signup")

class PasswordEncryption
end

describe SignUp do
  let(:encryptor) { PasswordEncryption }
  let(:signup) { SignUp.new(encryptor) }
  let(:user) { stub }

  it "does not signup the user when it's invalid" do
    user.should_receive(:valid?).and_return(false)
    signup.sign_up(user).should be_false
  end

  it "creates salt for the new user" do
    user.as_null_object
    user.should_receive(:salt=)
    user.should_receive(:new_record?).and_return(true)
    encryptor.should_receive(:make_salt)
    encryptor.stub(:encrypt => {})

    signup.sign_up(user)
  end
  
  it "encrypts the password with salt" do
    encrypted = "encrypted"
    user.as_null_object
    user.stub(:new_record? => false)
    encryptor.should_receive(:encrypt).and_return(encrypted)
    user.should_receive(:encrypted_password=).with(encrypted)

    signup.sign_up(user) 
  end

  it "saves the user" do
    user.as_null_object
    user.stub(:new_record? => false)
    user.should_receive(:save)
    encryptor.stub(:encrypt => {})

    signed_up = signup.sign_up(user)

    signed_up.should be_true
  end
end
