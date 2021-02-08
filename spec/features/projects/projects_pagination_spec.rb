require 'rails_helper'

RSpec.describe 'User sees all projects' do
  scenario 'they can click the next page to see next 10 projects' do
    FactoryBot.create_list(:project, 30)
    projects = Project.all.order(created_at: :desc)

    visit projects_path

    click_on 'page-2'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = projects.limit(10).offset(10).map(&:title)

    expect(displayed_project_titles).to eq(expected_project_titles)
  end

  scenario 'they can click the 3rd page to see projects in 20th-30th ' do
    FactoryBot.create_list(:project, 30)
    projects = Project.all.order(created_at: :desc)

    visit projects_path

    click_on 'page-3'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = projects.limit(10).offset(20).map(&:title)

    expect(displayed_project_titles).to eq(expected_project_titles)
  end
end
