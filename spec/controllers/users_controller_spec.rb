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

  describe "editting & updating" do
    before do
      @user = User.new(:name => "sam", :email => "sam@example.com",
                      :password => "password", :password_confirmation => "password")
      SignUp.new.sign_up(@user)
    end
    
    context "editting" do
      it "assigns the correct user" do
        get :edit, :id => @user.id
        assigns(:user).should == @user 
      end
    end

    context "updating" do
      before do
        @valid_params = { :name => "john", :email => "john@example.com", 
                          :password => "password", :password_confirmation => "password" }
      end

      it "does not update the user with invalid information" do
        put :update, { :id => @user.id, :user => @valid_params.merge!(:name => "") }
        flash[:error].should =~ /has not been updated./i
        response.should render_template("edit")
      end

      it "updates the user with correct information" do
        put :update, { :id => @user.id, :user => @valid_params }
        flash[:success].should =~ /has been updated./i
        response.should redirect_to(user_path(@user))
      end
    end
  end
end
