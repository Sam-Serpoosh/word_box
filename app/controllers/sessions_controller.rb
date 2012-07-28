class SessionsController < ApplicationController
  def create
    authenticated = authenticate_user
    if authenticated
      sign_in(@user)
      flash[:success] = "Signed in successfully."
      redirect_to user_path(@user)
    else
      flash[:error] = "Invalid email/password"
      render :action => "new"
    end
  end

  private
    def authenticate_user
      @user = AuthenticateUser.new.authenticate(params[:session][:email], 
                                                params[:session][:password])
    end
end
