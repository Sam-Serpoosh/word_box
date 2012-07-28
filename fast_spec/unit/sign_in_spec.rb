require_relative "../spec_helper_lite"
require_relative_to_root "app/services/sign_in"

describe "Sign in" do
  let(:sessions_helper) do
    stub(:create_cookie => {},
         :from_remember_token => nil).extend(SignIn)
  end 
  let(:user) { stub.as_null_object }

  it "creates cookie for signing in" do
    id, salt = 1, "salt"
    user = stub(:id => id, :salt => salt)
    sessions_helper.should_receive(:create_cookie).with(id, salt)
    sessions_helper.sign_in(user)
  end

  it "sets the current user after signing in" do
    user = stub.as_null_object
    sessions_helper.sign_in(user)
    sessions_helper.current_user.should == user
  end

  it "gets the current user from remember token if necessary" do
    user = stub.as_null_object
    sessions_helper.sign_in(user)
    sessions_helper.current_user = nil
    sessions_helper.current_user.should be_nil

    sessions_helper.should_receive(:from_remember_token).and_return(user)
    sessions_helper.current_user.should == user
  end

  it "knows when a user is signed in" do
    user = stub.as_null_object
    sessions_helper.sign_in(user)
    sessions_helper.signed_in?.should be_true
  end

  it "knows when a user is not signed in" do
    sessions_helper.signed_in?.should be_false 
  end

  it "signs the user out" do
    user = stub.as_null_object
    sessions_helper.should_receive(:delete_cookie)
    sessions_helper.sign_in(user)
    sessions_helper.sign_out
    sessions_helper.signed_in?.should be_false
  end
end
