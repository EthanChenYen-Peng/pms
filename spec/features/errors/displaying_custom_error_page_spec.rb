require 'rails_helper'

RSpec.feature 'User should see our custom error page' do
  let!(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
  end

  context 'locale: :en' do
    scenario 'when page not found users should see 404 page' do
      visit project_path(locale: :en, id: 23)

      expect(page).to have_content 'The page you are requesting does not exist!'
    end

    scenario 'when page not found users should see 500 page' do
      visit '/500'

      expect(page).to have_content 'Opps somthing wrong on our side :('
    end
  end

  context 'locale: :zh-TW' do
    scenario 'when page not found users should see 404 page' do
      visit project_path(locale: :'zh-TW', id: 23)

      expect(page).to have_content '此頁面不存在！'
    end

    scenario 'when page not found users should see 500 page' do
      visit '/zh-TW/500'

      expect(page).to have_content 'Opps 我們這邊出了點問題'
    end
  end
end
