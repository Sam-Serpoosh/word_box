require_relative "../spec_helper_lite"
require_relative_to_root "app/services/sign_up"

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
