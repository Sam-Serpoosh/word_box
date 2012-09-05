require 'spec_helper'

describe "Searching Words" do
  before do
    test_sign_up
    test_integration_sign_in
  end

  it "finds words according to the provided relative time" do
    add_new_word("hello", "salam")
    visit words_path
    
    select "today", :from => "Added When"
    click_button "Find Words"

    response.should have_selector("a", :content => "hello") 
  end
end
