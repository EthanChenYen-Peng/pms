require 'rails_helper'

RSpec.describe 'Accessing admin panel' do
  context 'As an admin' do
    scenario 'I can access admin panel once I login' do
      user = FactoryBot.create(:user, admin: true)

      login_as(user)
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
  end
end
