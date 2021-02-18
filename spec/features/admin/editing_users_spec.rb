require 'rails_helper'

RSpec.feature 'As an admin, I can edit user info' do

  before do
    FactoryBot.create(:user, email: 'ethan@gmail.com')
    admin = FactoryBot.create(:user, admin: true)
    user = FactoryBot.create(:user)
    login_as(admin)

    click_on 'Admin'
    click_on 'Users'
    click_on user.email
    click_on 'Edit'
  end

  scenario 'with valid inputs' do
    fill_in 'user[username]', with: 'JohnDoe'
    fill_in 'user[email]', with: 'johndoe@gmail.com'
    fill_in 'user[password]', with: 'astrongpassword'

    click_button 'Update'
    expect(page).to have_content 'Account has been updated.'
    expect(page).to have_content 'johndoe@gmail.com'
  end

  scenario 'with invalid inputs' do
    fill_in 'user[email]', with: 'ethan@gmail.com'

    click_button 'Update'
    expect(page).to have_content 'Account has not been updated.'
    expect(page).to have_content 'Email has already been taken'
    expect(page).to_not have_content 'ethan@gmail.com'
  end
end
