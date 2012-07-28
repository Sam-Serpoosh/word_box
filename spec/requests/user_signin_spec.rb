require 'spec_helper'

describe "Sign in" do
  it "signs the user in" do
    test_sign_up
    visit signin_path
    fill_in "Email", :with => "sam@example.com"
    fill_in "Password", :with => "password"
    click_button "Sign in"
    flash[:success].should =~ /successfully./
    response.should have_selector("h2", :content => "Sam")
  end
end
