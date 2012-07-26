require File.expand_path(File.dirname(__FILE__) + "/../app/services/signup")

class SignUp
end

describe UpdateUserInfo do
  it "delegates to SignUp" do
    updated = "updated user!"
    user = stub
    signup = stub(:sign_up => updated)
    SignUp.stub(:new => signup)

    updated = UpdateUserInfo.update_info(user)

    updated.should == updated 
  end
end
