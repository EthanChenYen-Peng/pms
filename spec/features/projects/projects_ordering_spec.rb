require 'rails_helper'

RSpec.feature 'Projects can be sorted' do
  before :each do
    Project.delete_all
    FactoryBot.create(:project, title: 'project 1', created_at: Date.today, due_date: Date.today + 1, priority: 'high')
    FactoryBot.create(:project, title: 'project 2', created_at: Date.today + 1, due_date: Date.today + 2,
                                priority: 'medium')
    FactoryBot.create(:project, title: 'project 3', created_at: Date.today - 1, due_date: Date.today, priority: 'low')
  end

  scenario 'by default with "created_at" field in "descending" order ' do
    visit projects_path
    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['project 2', 'project 1', 'project 3']
    expect(displayed_project_titles).to eq(expected_project_titles)
  end

  scenario 'by "due_date" field with "descending" order' do
    visit projects_path

    select 'Due date', from: 'sort_by'
    select 'Descending', from: 'order_direction'
    click_button 'Sort'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['project 2', 'project 1', 'project 3']
    expect(displayed_project_titles).to eq(expected_project_titles)
  end

  scenario 'by "due_date" field with "ascending" order' do
    visit projects_path

    select 'Due date', from: 'sort_by'
    select 'Ascending', from: 'order_direction'
    click_button 'Sort'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['project 3', 'project 1', 'project 2']
    expect(displayed_project_titles).to eq(expected_project_titles)
  end

  scenario 'by "priority" field with "descending" order' do
    visit projects_path

    select 'Priority', from: 'sort_by'
    select 'Descending', from: 'order_direction'
    click_button 'Sort'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['project 1', 'project 2', 'project 3']
    expect(displayed_project_titles).to eq(expected_project_titles)
  end

  scenario 'by "priority" field with "ascending" order' do
    visit projects_path

    select 'Priority', from: 'sort_by'
    select 'Ascending', from: 'order_direction'
    click_button 'Sort'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['project 3', 'project 2', 'project 1']
    expect(displayed_project_titles).to eq(expected_project_titles)
  end
end
