require_relative "../spec_helper_lite"
require_relative_to_root "app/services/authenticate_user"

class User; end
class PasswordEncryption; end

describe AuthenticateUser do
  context "#authenticate" do
    let(:authenticator) { AuthenticateUser.new(PasswordEncryption) }
    let(:user) { stub }

    before do
      User.stub(:find_by_email => user)
    end

    it "returns nil when there is no user with provided email" do
      User.stub(:find_by_email => nil)
      authenticator.authenticate("not existed user", "any password").should be_nil 
    end

    it "returns nil when password is wrong" do
      submitted_password = "wrong password"
      user.stub(:salt => "salt", :encrypted_password => "encrypted")
      PasswordEncryption.should_receive(:encrypt).and_return("wrong encryption")
      subject.authenticate(user, submitted_password).should be_nil 
    end
    
    it "returns user when password is correct" do
      salt, submitted_password = "salt", "password"
      user.stub(:salt => "salt", :encrypted_password => "encrypted")
      PasswordEncryption.should_receive(:encrypt).with("#{salt}--#{submitted_password}").
        and_return("encrypted")
      subject.authenticate(user, submitted_password).should == user 
    end
  end

  context "#authenticate_with_salt" do
    let(:authenticator) { AuthenticateUser }
    let(:user) { stub }

    before do
      User.stub(:find_by_id => user)
    end

    it "returns nil when user not found" do
      id, salt = stub, stub
      User.should_receive(:find_by_id).and_return(nil)
      authenticator.authenticate_with_salt(id, salt).should be_nil 
    end

    it "returns nil when salt is not corect" do
      id = stub
      user.stub(:salt => "salt")
      authenticator.authenticate_with_salt(id, "wrong salt").should be_nil 
    end

    it "returns true when salt is correct" do
      id, salt = stub, "salt"
      user.stub(:salt => salt)
      authenticator.authenticate_with_salt(id, salt).should == user 
    end
  end
end
