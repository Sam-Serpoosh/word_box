class SessionsController < ApplicationController

  def new
    @title = "sign in"
  end

  def create
    authenticated = authenticate_user
    if authenticated
      sign_in(@user)
      flash[:success] = "Signed in successfully."
      redirect_to user_path(@user)
    else
      flash.now[:error] = "Invalid email/password"
      render :action => "new"
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private
    def authenticate_user
      @user = AuthenticateUser.new.authenticate(params[:session][:email], 
                                                params[:session][:password])
    end
end
