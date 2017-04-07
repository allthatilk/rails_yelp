require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end
  context "users can edit/delete restaurants" do
    it "users can only edit/delete restaurants that they've created" do
      visit ('/')
      sign_up("test@test.com", "password")
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Wasabi'
      click_button 'Create Restaurant'
      click_link 'Sign out'
      sign_up("test2@test.com", "password1")
      click_link "Edit Wasabi"
      expect(page).to have_content("You do not have permission to edit this restaurant")
    end
  end
end
