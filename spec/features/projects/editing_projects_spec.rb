require 'rails_helper'

RSpec.feature 'Users can edit projects' do
  context 'locale: en' do
    let(:user) { FactoryBot.create(:user) }
    scenario 'get redirected to login path' do
      project = FactoryBot.create(:project)
      visit edit_user_project_path(:en, user, project)

      expect(page).to have_content 'You need to login first.'
    end

    scenario "cannot reach page to edit other user's project" do
      login_as(user)
      project = FactoryBot.create(:project)
      visit edit_user_project_path(:en, user, project)

      expect(page).to have_content 'You can only edit or delete your own article'
    end

    scenario 'with valid inputs' do
      login_as(user)
      project = FactoryBot.create(:project, user: user)
      visit user_projects_path(:en, user, project)

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
      visit user_projects_path(:en, user, project)

      click_link project.title
      click_link 'Edit Project'

      fill_in 'project[title]', with: ''
      fill_in 'project[content]', with: 'New content'

      click_button 'Update Project'

      expect(page).to have_content 'Project has not been updated.'
      expect(page).to have_content "Title can't be blank"
    end

    context 'when the project has labels' do
      let(:project) { FactoryBot.create(:project, user: user) }
      before do
        project.labels << FactoryBot.create(:label, name: 'PMS')
        project.labels << FactoryBot.create(:label, name: 'React')
        login_as(user)
        visit user_project_path(:en, user, project)
      end

      it 'sees existing labels on the edit form' do
        click_link 'Edit Project'

        within '.labels' do
          expect(page).to have_content 'PMS'
          expect(page).to have_content 'React'
        end
      end

      it 'can add new labels to a project' do
        click_link 'Edit Project'
        fill_in 'Labels', with: 'bug, Vue'
        click_button 'Update Project'

        expect(page).to have_content 'Project has been updated'

        within '.labels' do
          expect(page).to have_content('PMS')
          expect(page).to have_content('React')
          expect(page).to have_content('bug')
          expect(page).to have_content('Vue')
        end
      end

      it 'will not add the same label twice' do
        click_link 'Edit Project'
        fill_in 'Labels', with: 'bug, Vue, PMS, React'
        click_button 'Update Project'

        expect(page).to have_content 'Project has been updated'

        within '.labels' do
          expect(page).to have_content('PMS')
          expect(page).to have_content('React')
          expect(page).to have_content('bug')
          expect(page).to have_content('Vue')
        end
      end
    end
  end

  context 'locale: zh-TW' do
    let(:user) { FactoryBot.create(:user) }
    scenario 'get redirected to login path' do
      visit new_user_project_path(:'zh-TW', user)

      expect(page).to have_content '您需要先登錄'
    end

    scenario "cannot reach page to edit other user's project" do
      login_as(user)
      project = FactoryBot.create(:project)
      visit edit_user_project_path(:'zh-TW', user, project)

      expect(page).to have_content '您只能編輯或刪除自己的文章'
    end

    scenario 'with valid inputs' do
      login_as(user)
      project = FactoryBot.create(:project, user: user)
      visit user_projects_path(:'zh-TW', user)

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
      visit user_projects_path(:'zh-TW', user)

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
