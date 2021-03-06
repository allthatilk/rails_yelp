require 'rails_helper'

feature 'restaurants' do
  context 'have not been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end
  context 'restaurants added' do
    before do
      Restaurant.create(name: 'Wasabi')
    end

    scenario 'can be displayed' do
      visit '/restaurants'
      expect(page).to have_content('Wasabi')
      expect(page).not_to have_content('No restaurants yet')
    end
  end
  context 'creation' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up("test@test.com", "password")
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Wasabi'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Wasabi'
      expect(current_path).to eq '/restaurants'
    end
  end
  context 'is invalid' do
    scenario 'does not let you submit a name that is too short' do
      sign_up("test@test.com", "password")
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end
  context 'viewing' do
  let!(:wasabi){ Restaurant.create(name:'Wasabi') }

    scenario 'lets a user view a restaurant' do
     visit '/restaurants'
     click_link 'Wasabi'
     expect(page).to have_content 'Wasabi'
     expect(current_path).to eq "/restaurants/#{wasabi.id}"
    end
  end
  context 'editing' do
  # before { Restaurant.create name: 'Wasabi', description: 'tofu curry!!!', id: 1 }
    scenario 'lets a user edit a restaurant' do
      sign_up("test@test.com", "password")
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Wasabi'
      click_button 'Create Restaurant'
      click_link 'Edit Wasabi'
      fill_in 'Name', with: 'Wasabi bento'
      fill_in 'Description', with: 'tofu curry!!!'
      click_button 'Update Restaurant'
      click_link 'Wasabi bento'
      expect(page).to have_content 'Wasabi bento'
      expect(page).to have_content 'tofu curry!!!'
      # expect(current_path).to eq '/restaurants/1'
    end
  end
  context 'deleting restaurants' do

  # before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' } # need to look at how database is being cleaned

    scenario 'removes a restaurant when a user clicks a delete link' do
      sign_up("test@test.com", "password")
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end
