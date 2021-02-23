require 'rails_helper'

RSpec.feature 'Users can edit projects' do
  let(:user) { FactoryBot.create(:user) }

  context 'locale: en' do
    scenario 'get redirected to login path' do
      project = FactoryBot.create(:project)
      visit edit_project_path(locale: :en, id: project.id)

      expect(page).to have_content 'You need to login first.'
    end

    scenario "cannot reach page to edit other user's project" do
      login_as(user)
      project = FactoryBot.create(:project)
      visit edit_project_path(locale: :en, id: project.id)

      expect(page).to have_content 'You can only edit or delete your own project'
    end

    scenario 'with valid inputs' do
      login_as(user)
      project = FactoryBot.create(:project, user: user)
      visit projects_path

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
      login_as(user)
      project = FactoryBot.create(:project, user: user)
      visit projects_path

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
    scenario 'get redirected to login path' do
      visit new_project_path(locale: 'zh-TW')

      expect(page).to have_content '您需要先登錄'
    end

    scenario "cannot reach page to edit other user's project" do
      login_as(user)
      project = FactoryBot.create(:project)
      visit edit_project_path(locale: 'zh-TW', id: project.id)

      expect(page).to have_content '您只能編輯或刪除自己的專案'
    end

    scenario 'with valid inputs' do
      login_as(user)
      project = FactoryBot.create(:project, user: user)
      visit projects_path(locale: 'zh-TW')

      click_link project.title
      click_link '編輯專案'

      fill_in 'project[title]', with: 'New title'
      fill_in 'project[content]', with: 'New content'

      click_button '更新專案'

      expect(page).to have_content '專案已更新'
      expect(page).to have_content 'New title'
      expect(page).to have_content 'New content'
    end

    scenario 'with invalid inputs' do
      login_as(user)
      project = FactoryBot.create(:project, user: user)
      visit projects_path(locale: 'zh-TW')

      click_link project.title
      click_link '編輯專案'

      fill_in 'project[title]', with: ''
      fill_in 'project[content]', with: 'New content'

      click_button '更新專案'

      expect(page).to have_content '專案更新失敗'
      expect(page).to have_content '標題不能為空'
    end
  end
end
