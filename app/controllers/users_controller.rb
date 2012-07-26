class UsersController < ApplicationController
  before_filter :find_user, :only => [:show]
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
      flash[:error] = "User has not been created."
      render :action => "new"
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
end
