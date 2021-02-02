require 'rails_helper'

RSpec.feature 'Users can create project' do
  context 'locale: en' do
    scenario 'with valid inputs' do
      visit new_project_path

      fill_in 'project[title]', with: 'write a blog'
      fill_in 'project[content]', with: 'blog content'

      click_button 'Create Project'

      expect(page).to have_content 'Project has been created.'
      expect(page).to have_content 'write a blog'
      expect(page).to have_content 'blog content'
    end

    scenario 'with invalid inputs' do
      visit new_project_path
      click_button 'Create Project'

      expect(page).to have_content 'Project has not been created.'
      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Content can't be blank"
    end

    scenario 'with duplicate title' do
      FactoryBot.create(:project, title: 'project1')
      visit new_project_path
      fill_in 'project[title]', with: 'project1'
      fill_in 'project[content]', with: 'blog content'
      click_button 'Create Project'

      expect(page).to have_content 'Project has not been created.'
      expect(page).to have_content 'Title has already been taken'
    end
  end

  context 'locale: zh-TW' do
    scenario 'with valid inputs' do
      visit new_project_path(locale: 'zh-TW')

      fill_in 'project[title]', with: 'write a blog'
      fill_in 'project[content]', with: 'blog content'

      click_button '新專案'

      expect(page).to have_content '專案已創建'
      expect(page).to have_content 'write a blog'
      expect(page).to have_content 'blog content'
    end

    scenario 'with invalid inputs' do
      visit new_project_path(locale: 'zh-TW')
      click_button '新專案'

      expect(page).to have_content '專案創建失敗'
      expect(page).to have_content '標題不能為空'
      expect(page).to have_content '內容不能為空'
    end

    scenario 'with duplicate title' do
      FactoryBot.create(:project, title: 'project1')
      visit new_project_path(locale: 'zh-TW')
      fill_in 'project[title]', with: 'project1'
      fill_in 'project[content]', with: 'blog content'
      click_button '新專案'

      expect(page).to have_content '專案創建失敗'
      expect(page).to have_content '標題已經存在'
    end
  end
end
