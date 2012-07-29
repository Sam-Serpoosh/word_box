require 'spec_helper'

describe "Editting user info" do
  it "updates user information" do
    test_sign_up
    test_integration_sign_in
    new_name = "John"

    click_link "Settings"
    fill_in "Name", :with => new_name
    fill_in "Email", :with => "john@example.com" 
    fill_in "Password", :with => "password"
    fill_in "Confirmation", :with => "password"
    click_button "Update User"

    response.should have_selector("h2", :content => new_name)
  end
end
