require 'spec_helper'

describe SessionsController do
  context "#creating" do
    it "re-render sign in template with invalid sign in" do
      post :create, :session => { :email => "" }
      flash[:error].should =~ /invalid email\/password/i
      response.should render_template("new")
    end
  end
end
