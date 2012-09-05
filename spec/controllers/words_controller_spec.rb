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

#      it "lists words of the current user" do
#        get :index
#        response.should have_selector("td", :content => @words.first.vocabulary) 
#      end #it's a view test and I don't like to test view!
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

  describe "editting and updating" do
    before do
      @user = FactoryGirl.create(:user)
      @word = FactoryGirl.create(:word, :user => @user)
    end

    context "#deny_access" do
      it "denies access to editting word when not signed in" do
        get :edit, :id => @word.id
        response.should redirect_to(signin_path)
      end

      it "denies access to update word when not signed in" do
        put :update, :id => {}
        response.should redirect_to(signin_path) 
      end
    end

    context "#have_access" do
      before do 
        test_sign_in(@user)
      end

      it "assings the correct word for editting" do
        get :edit, :id => @word
        assigns(:word).should == @word
      end

      it "doesn't updates the word with wrong values" do
        put :update, { :id => @word.id, :word => { :vocabulary => "" } }
        flash[:error].should =~ /not been updated./i
        response.should render_template("edit")
      end

      it "updates the word" do
        put :update, :id => @word.id, :word => { :vocabulary => "hi" } 
        flash[:success].should =~ /been updated./i
        response.should redirect_to(word_path(@word))

        @word.reload
        @word.vocabulary.should == "hi"
      end
    end
  end

  describe "deleting" do
    before do
      @user = FactoryGirl.create(:user)
      @word = FactoryGirl.create(:word, :user => @user)
      test_sign_in(@user)
    end

    context "#others_words" do
      before do
        @other_user = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
        @other_word = FactoryGirl.create(:word)
      end
      
      it "can't delete other's words" do
        delete :destroy, :id => @other_word.id
        flash[:error].should =~ /can't delete others words./i
        response.should redirect_to(words_path)
      end
    end

    context "#own_words" do
      it "deletes the word" do
        delete :destroy, :id => @word.id
        flash[:success].should =~ /deleted./i
        response.should redirect_to(words_path)
      end
    end
  end
end
