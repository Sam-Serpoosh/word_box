def test_integration_sign_in
  visit signin_path
  fill_in "Email", :with => "sam@example.com"
  fill_in "Password", :with => "password"
  click_button "Sign in"
end
