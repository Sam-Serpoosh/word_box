require 'spec_helper'

describe "Editing a word" do
  before do
    test_sign_up
    test_integration_sign_in
  end

  it "edits a word" do
    old_word = "hello"
    new_word = "hi"
    add_new_word(old_word, "salam")
    visit words_path

    click_link old_word 
    click_link "Edit Word"
    fill_in :vocabulary, :with => new_word 
    click_button "Update Word"

    response.should have_selector("h3", :content => new_word)
  end
end
