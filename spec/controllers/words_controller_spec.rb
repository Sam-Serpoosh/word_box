require 'spec_helper'

describe WordsController do
  render_views

  before do
    @user = FactoryGirl.create(:user)
  end

  describe "listing" do
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

  describe "Adding Word" do
    context "#deny_access" do
      it "doesn't let adding a word when not signed in" do
        get :new
        response.should redirect_to(signin_path)
      end
    end

    context "#having_access" do
      before do
        test_sign_in(@user)
      end

      it "assigns an empty word for the form" do
        get :new 
        assigns(:word).should_not be_nil
      end

      it "re-render new word page when word is invalid" do
        post :create, :word => {}
        flash[:error].should =~ /invalid vocabulary\/meaning/i
        response.should render_template(:new)
      end

      it "creates the word and goes to its show page" do
        post :create, :word => { :vocabulary => "hello", :meaning => "salam" }
        flash[:success].should =~ /added word/i
        response.should redirect_to(assigns(:word))
      end
    end
  end

  describe "showing" do
    it "assings the right word" do
      word = FactoryGirl.create(:word)
      get :show, :id => word.id
      assigns(:word).should == word
    end
  end
end
