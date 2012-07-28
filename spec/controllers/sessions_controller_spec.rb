require 'spec_helper'

describe SessionsController do
  context "#creating" do
    it "re-render sign in template with invalid sign in" do
      post :create, :session => { :email => "" }
      flash.now[:error].should =~ /invalid email\/password/i
      response.should render_template("new")
    end
  end

  context "#destroying" do
    it "signs the user out" do
      delete :destroy
      response.should redirect_to(root_path)
    end
  end
end
