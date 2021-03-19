require 'rails_helper'

RSpec.feature 'Visiting homepage' do
  context 'guest user' do
    scenario 'sees homepage with link to signup page' do
      visit root_path

      click_on 'Get Started'

      expect(current_path).to eq(signup_path(locale: :en))
    end
  end

  context 'authenticated user' do
    scenario 'get redirected to his own project page' do
      user = FactoryBot.create(:user)
      login_as(user)
      visit root_path

      expect(current_path).to eq(user_projects_path(:en, user))
    end
  end
end
