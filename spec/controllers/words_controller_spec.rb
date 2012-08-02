require 'spec_helper'

describe WordsController do
  render_views

  describe "listing" do
    before do
      @user = FactoryGirl.create(:user)
    end

    context "#deny_access" do
      it "denies access to words when not signed in" do
        get :index
        response.should redirect_to(signin_path)
      end
    end

    context "#having_access" do
      before do
        test_sign_in(@user)
        @words = ["one", "two"].map { |vocab| FactoryGirl.create(:word, :vocabulary => vocab, :user => @user) }
      end

      it "assigns words of current user" do
        get :index
        assigns(:words).should == @words
      end

      it "lists words of the current user" do
        get :index
        response.should have_selector("td", :content => @words.first.vocabulary) 
      end
    end
  end
end
