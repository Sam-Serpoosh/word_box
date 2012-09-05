require 'spec_helper'

describe SearchWordsController do
  context "#today_words" do
    it "returns only today words" do
      words = stub
      Word.stub(:today => words)
      get :find_words
      assigns(:words).should == words
    end
  end
end
