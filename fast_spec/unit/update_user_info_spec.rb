require_relative "../spec_helper_lite"
require_relative_to_root "app/services/update_user_info"

class SignUp
end

describe UpdateUserInfo do
  it "delegates to SignUp" do
    updated = "updated user!"
    user = stub
    signup = stub(:sign_up => updated)
    SignUp.stub(:new => signup)

    UpdateUserInfo.new(SignUp.new).update(user).should == updated
  end
end
