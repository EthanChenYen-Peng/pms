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
    before do
      login_as(FactoryBot.create(:user))
    end
    scenario 'get redirected to his own project page' do
      visit root_path

      expect(current_path).to eq(projects_path(locale: :en))
    end
  end
end
