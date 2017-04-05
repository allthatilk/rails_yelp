require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'KFC' }

  scenario 'allows users to leave a review using a form' do
     visit '/restaurants'
     click_link 'Review KFC'
     fill_in "Thoughts", with: "is this actually chicken?"
     select '1', from: 'Rating'
     click_button 'Leave Review'

     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('is this actually chicken?')
  end
end
