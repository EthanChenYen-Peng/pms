require 'rails_helper'

RSpec.feature 'Registered users can login into thier accounts' do
  context 'locale: en' do
    let(:user) { FactoryBot.create(:user) }
    scenario 'with correct username and password' do
      visit root_path

      click_on 'Login'

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_button 'Login'
      expect(page).to have_content 'Login successfully'
      expect(page).to have_content user.username
    end

    scenario 'with incorrect username or password' do
      visit root_path

      click_on 'Login'

      click_button 'Login'
      expect(page).to have_content 'Invalid credentials'
    end
  end

  context 'locale: en' do
    let(:user) { FactoryBot.create(:user) }

    before do
      visit root_path(locale: 'zh-TW')
      click_on '登入'
    end
    scenario 'with correct username and password' do
      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_button '登入'
      expect(page).to have_content '登入成功'
      expect(page).to have_content user.username
    end

    scenario 'with incorrect username or password' do
      click_button '登入'
      expect(page).to have_content '密碼或用戶名不正確'
    end
  end
end
