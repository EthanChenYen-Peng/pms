require 'rails_helper'

RSpec.feature 'Users can register for an account' do
  context 'locale: en' do
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

    scenario 'with invalid inputs' do
      visit root_path

      click_on 'Sign Up'
      click_button 'Sign up'
      expect(page).to have_content 'Account has not been created.'
      expect(page).to have_content "Username can't be blank"
      expect(page).to have_content "Email can't be blank"
      expect(page).to have_content "Password can't be blank"
    end

    scenario 'password not match' do
      visit root_path

      click_on 'Sign Up'

      fill_in 'user[username]', with: 'JohnDoe'
      fill_in 'user[email]', with: 'johndoe@gmail.com'
      fill_in 'user[password]', with: 'astrongpassword'
      fill_in 'user[password_confirmation]', with: 'wrongpassword'

      click_button 'Sign up'
      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    scenario 'username and email already been taken' do
      FactoryBot.create(:user, username: 'JohnDoe', email: 'johndoe@gmail.com')

      visit root_path

      click_on 'Sign Up'

      fill_in 'user[username]', with: 'JohnDoe'
      fill_in 'user[email]', with: 'johndoe@gmail.com'
      fill_in 'user[password]', with: 'astrongpassword'
      fill_in 'user[password_confirmation]', with: 'astrongpassword'

      click_button 'Sign up'
      expect(page).to have_content 'Account has not been created.'
      expect(page).to have_content 'Username has already been taken'
      expect(page).to have_content 'Email has already been taken'
    end
  end

  context 'locale: zh-TW' do
    scenario 'with valid inputs' do
      visit root_path(locale: 'zh-TW')

      click_on '註冊'

      fill_in 'user[username]', with: 'JohnDoe'
      fill_in 'user[email]', with: 'johndoe@gmail.com'
      fill_in 'user[password]', with: 'astrongpassword'
      fill_in 'user[password_confirmation]', with: 'astrongpassword'

      click_button '註冊'
      expect(page).to have_content '帳戶已創建'
    end

    scenario 'with invalid inputs' do
      visit root_path(locale: 'zh-TW')

      click_on '註冊'

      click_button '註冊'

      expect(page).to have_content '帳戶創建失敗'
      expect(page).to have_content '用戶名不能為空'
      expect(page).to have_content 'Email 不能為空'
      expect(page).to have_content '密碼不能為空'
    end

    scenario 'password not match' do
      visit root_path(locale: 'zh-TW')

      click_on '註冊'

      fill_in 'user[username]', with: 'JohnDoe'
      fill_in 'user[email]', with: 'johndoe@gmail.com'
      fill_in 'user[password]', with: 'astrongpassword'
      fill_in 'user[password_confirmation]', with: 'wrongpassword'

      click_button '註冊'
      expect(page).to have_content '密碼不匹配'
    end

    scenario 'username and email already been taken' do
      FactoryBot.create(:user, username: 'JohnDoe', email: 'johndoe@gmail.com')

      visit root_path(locale: 'zh-TW')

      click_on '註冊'

      fill_in 'user[username]', with: 'JohnDoe'
      fill_in 'user[email]', with: 'johndoe@gmail.com'
      fill_in 'user[password]', with: 'astrongpassword'
      fill_in 'user[password_confirmation]', with: 'astrongpassword'

      click_button '註冊'
      expect(page).to have_content '帳戶創建失敗'
      expect(page).to have_content '用戶名已經存在'
      expect(page).to have_content 'Email 經存在'
    end
  end
end
