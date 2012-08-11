require 'spec_helper'

describe "Adding a New Word" do
  before do
    test_sign_up
    test_integration_sign_in
    @new_word = "hello"
  end

  it "adds a word" do
    add_new_word(@new_word, "salam")
    response.should have_selector("h3", :content => @new_word)
  end

  it "adds a new word and include it in the current user words list" do
    add_new_word(@new_word, "salam")
    visit words_path
    response.should have_selector("td", :content => @new_word)
  end
end
