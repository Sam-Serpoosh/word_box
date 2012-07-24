require 'spec_helper'

describe UsersController do
  describe "newing" do
    it "assigns the empty user" do
      get :new
      assigns(:user).should_not be_nil
    end
  end

  describe "creating" do
    it "doesn't create user with invalid information" do
      post :create, :user => { :name => "" }
      flash[:error].should =~ /has not been created./
      response.should render_template("new")
    end

    it "creates user with valid information" do
      post :create, :user => { :name => "sam", :email => "sam@example.com",
                               :password => "password", :password_confirmation => "password" }
      flash[:success].should =~ /signed up successfully./i
      response.should redirect_to(user_path(assigns(:user)))
    end
  end
end
