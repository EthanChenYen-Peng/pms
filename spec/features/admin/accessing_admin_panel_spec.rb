require 'rails_helper'

RSpec.describe 'Accessing admin panel' do
  context 'As an admin' do
    scenario 'I can access admin panel once I login' do
      admin = FactoryBot.create(:user, admin: true)
      login_as(admin)

      click_on 'Admin'

      expect(page).to have_content('Welcome to the admin panel')
    end
  end

  context 'As a regular user' do
    scenario 'I cannot see "Admin" button even after I login' do
      user = FactoryBot.create(:user)
      login_as(user)

      expect(page).to_not have_content('Admin')
    end

    scenario 'I cannot access admin panel' do
      user = FactoryBot.create(:user)
      login_as(user)

      visit admin_root_path

      expect(page).to have_content('You are not authorized to access this page.')
      expect(current_path).to eq(user_projects_path(:en, user))
    end

    scenario "I cannot access the page to edit other user's info" do
      user_one = FactoryBot.create(:user)
      user_two = FactoryBot.create(:user)
      login_as(user_one)

      visit edit_admin_user_path(:en, user_two)

      expect(page).to have_content('You are not authorized to access this page.')
      expect(current_path).to eq(user_projects_path(:en, user_one))
    end

    scenario "I cannot view other user's page " do
      user_one = FactoryBot.create(:user)
      user_two = FactoryBot.create(:user)
      login_as(user_one)

      visit admin_user_path(:en, user_two)

      expect(page).to have_content('You are not authorized to access this page.')
      expect(current_path).to eq(user_projects_path(:en, user_one))
    end
  end
end
