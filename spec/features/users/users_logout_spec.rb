require 'rails_helper'

RSpec.feature 'Registered users can logout from thier accounts' do
  context 'locale: en' do
    scenario 'logout successfully' do
      user = FactoryBot.create(:user)
      login_as(user)

      click_on 'Logout'

      expect(page).to have_content 'Logout successfully'
    end
  end

  context 'locale: zh-TW' do
    scenario 'logout successfully' do
      user = FactoryBot.create(:user)
      login_as(user, 'zh-TW')

      click_on '登出'

      expect(page).to have_content '登出成功'
    end
  end
end
