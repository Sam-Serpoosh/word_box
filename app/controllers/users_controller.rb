class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :update]

  def new
    @user = User.new
  end

  def show
    find_user
  end
  
  def create
    signed_up = sign_up
    if signed_up
      success_action("Signed up successfully.", user_path(@user))
    else
      failed_action("User has not been created.", "new")
    end
  end

  def edit 
    find_user
  end

  def update
    find_user
    updated = update_info 
    if updated
      success_action("User has been updated.", user_path(@user))
    else
      failed_action("User has not been updated.", "edit")
    end
  end

  private
    def find_user
      @user = User.find(params[:id])
    end

    def sign_up
      @user = User.new(params[:user])
      SignUp.new.sign_up(@user)
    end

    def update_info
      @user.update_attributes(params[:user])
      UpdateUserInfo.new.update(@user)
    end
end
