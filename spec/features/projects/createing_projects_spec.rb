require 'rails_helper'

RSpec.feature 'Users can create project' do

  scenario 'with valid inputs' do
    visit new_project_path

    fill_in 'project[title]', with: 'write a blog'
    fill_in 'project[content]', with: 'blog content'

    click_button 'Create Project'

    expect(page).to have_content 'write a blog'
    expect(page).to have_content 'blog content'
  end
end
