require 'spec_helper'

describe PagesController do
  render_views

  context "#title" do
    it "has right title on home page " do 
      get :home
      response.should have_selector("title", :content => "Home")
    end

    it "has righ title on about page" do
      get :about
      response.should have_selector("title", :content => "About")
    end

    it "has righ title on contact page" do
      get :contact
      response.should have_selector("title", :content => "Contact")
    end
  end

  context"#links_while_signed_in" do
    before do
      test_sign_in(FactoryGirl.create(:user))
    end
    it "has words link" do
      get :home
      response.should have_selector("a", :content => "Words")
    end
  end
end
