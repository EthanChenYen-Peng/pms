require 'rails_helper'

RSpec.feature 'Users can delete projects' do
  let(:user) { FactoryBot.create(:user) }

  context 'locale: en' do
    scenario 'successfully deleting a project' do
      login_as(user)
      project = FactoryBot.create(:project, user: user)
      visit projects_path

      click_link project.title
      click_link 'Delete Project'

      expect(page).to have_content 'Project has been deleted.'
      expect(current_path).to eq projects_path(locale: :en)
      expect(page).to_not have_content project.title
      expect(page).to_not have_content project.content
    end

    scenario "cannot see button to delete other user's project" do
      login_as(user)
      project = FactoryBot.create(:project)
      visit projects_path

      click_link project.title
      expect(page).to_not have_content 'Delete Project'
    end
  end

  context 'locale: zh-TW' do
    scenario 'successfully deleting a project' do
      login_as(user)
      project = FactoryBot.create(:project, user: user)
      visit projects_path(locale: 'zh-TW')

      click_link project.title
      click_link '刪除專案'

      expect(page).to have_content '專案已刪除'
      expect(current_path).to eq projects_path(locale: 'zh-TW')
      expect(page).to_not have_content project.title
      expect(page).to_not have_content project.content
    end

    scenario "cannot see button to delete other user's project" do
      login_as(user)
      project = FactoryBot.create(:project)
      visit projects_path(locale: 'zh-TW')

      click_link project.title
      expect(page).to_not have_content '刪除專案'
    end
  end
end
