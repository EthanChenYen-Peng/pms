require 'rails_helper'

RSpec.feature 'Users can edit projects' do
  context 'locale: en' do
    scenario 'with valid inputs' do
      project = FactoryBot.create(:project)
      visit root_path

      click_link project.title
      click_link 'Edit Project'

      fill_in 'project[title]', with: 'New title'
      fill_in 'project[content]', with: 'New content'

      click_button 'Update Project'

      expect(page).to have_content 'Project has been updated.'
      expect(page).to have_content 'New title'
      expect(page).to have_content 'New content'
    end

    scenario 'with invalid inputs' do
      project = FactoryBot.create(:project)
      visit root_path

      click_link project.title
      click_link 'Edit Project'

      fill_in 'project[title]', with: ''
      fill_in 'project[content]', with: 'New content'

      click_button 'Update Project'

      expect(page).to have_content 'Project has not been updated.'
      expect(page).to have_content "Title can't be blank"
    end
  end

  context 'locale: zh-TW' do
    scenario 'with valid inputs' do
      project = FactoryBot.create(:project)
      visit root_path(locale: 'zh-TW')

      click_link project.title
      click_link 'Edit Project'

      fill_in 'project[title]', with: 'New title'
      fill_in 'project[content]', with: 'New content'

      click_button 'Update Project'

      expect(page).to have_content '專案已更新'
      expect(page).to have_content 'New title'
      expect(page).to have_content 'New content'
    end

    scenario 'with invalid inputs' do
      project = FactoryBot.create(:project)
      visit root_path(locale: 'zh-TW')

      click_link project.title
      click_link 'Edit Project'

      fill_in 'project[title]', with: ''
      fill_in 'project[content]', with: 'New content'

      click_button 'Update Project'

      expect(page).to have_content '專案更新失敗'
      expect(page).to have_content '標題不能為空'
    end
  end
end
