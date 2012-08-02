class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :update]
  before_filter :find_user, :only => [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show; end
  
  def create
    signed_up = sign_up
    if signed_up
      flash[:success] = "Signed up successfully."
      redirect_to user_path(@user)
    else
      flash.now[:error] = "User has not been created."
      render :action => "new"
    end
  end

  def edit; end

  def update
    updated = update_info 
    if updated
      flash[:success] = "User has been updated."
      redirect_to user_path(@user)
    else
      flash[:error] = "User has not been updated."
      render :action => "edit"
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
