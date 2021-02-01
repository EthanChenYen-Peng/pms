require 'rails_helper'

RSpec.feature 'Users can edit projects' do
  let(:project) { FactoryBot.create(:project) }
  scenario 'with valid inputs' do
    visit edit_project_path(locale: :en, id: project.id)

    fill_in 'project[title]', with: 'New title'
    fill_in 'project[content]', with: 'New content'

    click_button 'Update Project'

    expect(page).to have_content 'Project has been updated.'
    expect(page).to have_content 'New title'
    expect(page).to have_content 'New content'
  end

  scenario 'with invalid inputs' do
    visit edit_project_path(locale: :en, id: project.id)

    fill_in 'project[title]', with: ''
    fill_in 'project[content]', with: 'New content'

    click_button 'Update Project'

    expect(page).to have_content 'Project has not been updated.'
    expect(page).to have_content "Title can't be blank"
  end
end
