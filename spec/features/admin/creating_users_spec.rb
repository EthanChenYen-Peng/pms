require 'rails_helper'

RSpec.feature 'As an admin, I can create user account' do
  before do
    FactoryBot.create(:user, email: 'ethan@gmail.com')
    admin = FactoryBot.create(:user, admin: true)
    login_as(admin)

    click_on 'Admin'
    click_on 'Users'
    click_on 'New User'
  end

  context 'with valid inputs' do
    scenario 'create regular user' do
      fill_in 'user[username]', with: 'JohnDoe'
      fill_in 'user[email]', with: 'johndoe@gmail.com'
      fill_in 'user[password]', with: 'astrongpassword'

      click_button 'Create User'
      expect(page).to have_content 'Account has been created.'
      expect(page).to have_content 'johndoe@gmail.com'
    end

    scenario 'create admin user' do
      fill_in 'user[username]', with: 'JohnDoe'
      fill_in 'user[email]', with: 'johndoe@gmail.com'
      fill_in 'user[password]', with: 'astrongpassword'
      check 'user[admin]'

      click_button 'Create User'
      expect(page).to have_content 'Account has been created.'

      user = User.find_by(email: 'johndoe@gmail.com')
      expect(user.admin?).to be(true)
      expect(page).to have_content 'johndoe@gmail.com'
    end
  end

  context 'with invalid inputs' do
    scenario 'with email that has already been taken' do
      fill_in 'user[username]', with: 'JohnDoe'
      fill_in 'user[email]', with: 'ethan@gmail.com'
      fill_in 'user[password]', with: 'astrongpassword'

      click_button 'Create User'
      expect(page).to have_content 'Account has not been created.'
      expect(page).to have_content 'Email has already been taken'
    end
  end
end
