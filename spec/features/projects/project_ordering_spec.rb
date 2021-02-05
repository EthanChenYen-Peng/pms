require 'rails_helper'

RSpec.feature 'Projects are sorted' do
  before do
    @projects = []
    10.times do
      @projects << FactoryBot.create(:project)
    end
  end

  scenario 'by "created_at" field"' do
    visit projects_path
    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = @projects.sort_by(&:created_at).reverse.map(&:title)
    expect(displayed_project_titles).to eq(expected_project_titles)
  end

  scenario 'sort by "due_date" field with "descending" order' do
    visit projects_path

    select 'Due date', from: 'sort_by'
    select 'Descending', from: 'order_direction'
    click_button 'Sort'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = @projects.sort_by(&:due_date).reverse.map(&:title)
    expect(displayed_project_titles).to eq(expected_project_titles)
  end

  scenario 'sort by "due_date" field with "ascending" order' do
    visit projects_path

    select 'Due date', from: 'sort_by'
    select 'Ascending', from: 'order_direction'
    click_button 'Sort'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = @projects.sort_by(&:due_date).map(&:title)
    expect(displayed_project_titles).to eq(expected_project_titles)
  end
end
