require 'spec_helper'

describe "UserSignups" do
  it "signs the user up" do
    visit signup_path
    fill_in "Name", :with => "sam"
    fill_in "Email", :with => "sam@example.com"
    fill_in "Password", :with => "password"
    fill_in "Confirmation", :with => "password"
    click_button "Create User"
    flash[:success].should =~ /signed up successfully./i
    response.should have_selector("h2", :content => "sam")
  end
end
