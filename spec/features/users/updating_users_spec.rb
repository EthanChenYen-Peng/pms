require 'rails_helper'

RSpec.describe 'User can update her profile' do
  before do
    user = FactoryBot.create(:user)
    login_as user
    visit edit_user_path(:en, user)
  end

  context 'with valid attributes' do
    it 'updates the user profile' do
      fill_in 'user[username]', with: 'ethanchen'
      fill_in 'user[email]', with: 'ypcethan@gmail.com'
      click_on 'Update Profile'

      expect(page).to have_content 'Account has been updated.'
      expect(page).to have_content 'ethanchen'
      expect(page).to have_content 'ypcethan@gmail.com'
    end
  end

end
