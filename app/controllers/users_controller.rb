class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Signed up successfully."
      redirect_to user_path(@user)
    else
      flash[:error] = "User has not been created."
      render :action => "new"
    end
  end
end
