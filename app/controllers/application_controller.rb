class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def authenticate_user!
    if !signed_in?
      flash.now[:error] = "You should sign in first."
      redirect_to signin_path
    end
  end
end
