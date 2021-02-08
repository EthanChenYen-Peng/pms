require 'rails_helper'

RSpec.feature 'Users can register for an account' do

  scenario 'with valid inputs' do
    visit root_path

    click_on 'Sign Up'
    
    fill_in 'user[username]', with: 'JohnDoe'
    fill_in 'user[email]', with: 'johndoe@gmail.com'
    fill_in 'user[password]', with: 'astrongpassword'
    fill_in 'user[password_confirmation]', with: 'astrongpassword'

    click_button 'Sign up'
    expect(page).to have_content 'Account has been created.'
  end
end
