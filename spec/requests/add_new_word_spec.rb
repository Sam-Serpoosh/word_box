require 'spec_helper'

describe "Adding a New Word" do
  before do
    test_sign_up
    test_integration_sign_in
  end

  it "adds a word" do
    add_new_word
    response.should have_selector("h3", :content => @new_word)
  end

  it "adds a new word and include it in the current user words list" do
    add_new_word
    visit words_path
    response.should have_selector("td", :content => @new_word)
  end

  def add_new_word
    @new_word = "hello"
    visit words_path
    click_link "Add Word"
    fill_in "Vocabulary", :with => @new_word
    fill_in "Meaning", :with => "salam"
    click_button "Create Word"
  end
end
