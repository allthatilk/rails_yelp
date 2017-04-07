def sign_up(email, password)
  visit '/restaurants'
  click_link "Sign up"
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  fill_in :user_password_confirmation, with: password
  click_button "Sign up"

end

def sign_in
  visit '/restaurants'
  click_button "Sign in"
  fill_in :user_email, with: "test@test.com"
  fill_in :user_password, with: 12345678
  click_button "Sign in"
end
