class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def authenticate_user!
    if !signed_in?
      flash.now[:error] = "You should sign in first."
      redirect_to signin_path
    end
  end

  def success_action(message, redirect_path)
    flash[:success] = message
    redirect_to redirect_path
  end
  
  def failed_action(message, action)
    flash[:error] = message
    render :action => action
  end
end
