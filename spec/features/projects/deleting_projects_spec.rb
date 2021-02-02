require 'rails_helper'

RSpec.feature 'Users can delete projects' do
  let!(:project) { FactoryBot.create(:project) }

  # TODO: User should only be able to delete her own project.
  context 'locale: en' do
    scenario 'successfully deleting a project' do
      visit root_path

      click_link project.title
      click_link 'Delete Project'

      expect(page).to have_content 'Project has been deleted.'
      expect(current_path).to eq projects_path(locale: :en)
      expect(page).to_not have_content project.title
      expect(page).to_not have_content project.content
    end
  end

  context 'locale: zh-TW' do
    scenario 'successfully deleting a project' do
      visit root_path(locale: 'zh-TW')

      click_link project.title
      click_link 'Delete Project'

      expect(page).to have_content '專案已刪除'
      expect(current_path).to eq projects_path(locale: 'zh-TW')
      expect(page).to_not have_content project.title
      expect(page).to_not have_content project.content
    end
  end
end
