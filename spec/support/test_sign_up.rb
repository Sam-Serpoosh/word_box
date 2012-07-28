def test_sign_up
  visit signup_path
  fill_in "Name", :with => "Sam"
  fill_in "Email", :with => "sam@example.com"
  fill_in "Password", :with => "password"
  fill_in "Confirmation", :with => "password"
  click_button "Create User"
end
