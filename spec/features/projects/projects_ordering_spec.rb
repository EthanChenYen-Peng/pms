require 'rails_helper'

RSpec.feature 'Projects can be sorted' do
  let(:user) { FactoryBot.create(:user) }
  before :each do
    login_as(user)
    FactoryBot.create(:project, title: 'project 1',
                                created_at: Date.today,
                                start_date: Date.today - 1,
                                due_date: Date.today + 1,
                                priority: 'high', user: user)
    FactoryBot.create(:project, title: 'project 2',
                                created_at: Date.today + 1,
                                start_date: Date.today,
                                due_date: Date.today + 2,
                                priority: 'medium', user: user)
    FactoryBot.create(:project, title: 'project 3',
                                created_at: Date.today - 1,
                                start_date: Date.today - 2,
                                due_date: Date.today,
                                priority: 'low', user: user)
  end

  scenario 'by default with "created_at" field in "descending" order ' do
    visit user_projects_path(:en, user)
    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['project 2', 'project 1', 'project 3']
    expect(displayed_project_titles).to eq(expected_project_titles)
  end

  scenario 'by "due_date" field with "descending" order' do
    visit user_projects_path(:en, user)

    select 'Due date', from: 'sort_by'
    select 'Descending', from: 'order_direction'
    click_button 'Sort'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['project 2', 'project 1', 'project 3']
    expect(displayed_project_titles).to eq(expected_project_titles)
  end

  scenario 'by "due_date" field with "ascending" order' do
    visit user_projects_path(:en, user)

    select 'Due date', from: 'sort_by'
    select 'Ascending', from: 'order_direction'
    click_button 'Sort'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['project 3', 'project 1', 'project 2']
    expect(displayed_project_titles).to eq(expected_project_titles)
  end

  scenario 'by "start_date" field with "descending" order' do
    visit user_projects_path(:en, user)

    select 'Start date', from: 'sort_by'
    select 'Descending', from: 'order_direction'
    click_button 'Sort'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['project 2', 'project 1', 'project 3']
    expect(displayed_project_titles).to eq(expected_project_titles)
  end

  scenario 'by "start_date" field with "ascending" order' do
    visit user_projects_path(:en, user)

    select 'Start date', from: 'sort_by'
    select 'Ascending', from: 'order_direction'
    click_button 'Sort'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['project 3', 'project 1', 'project 2']
    expect(displayed_project_titles).to eq(expected_project_titles)
  end

  scenario 'by "priority" field with "descending" order' do
    visit user_projects_path(:en, user)

    select 'Priority', from: 'sort_by'
    select 'Descending', from: 'order_direction'
    click_button 'Sort'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['project 1', 'project 2', 'project 3']
    expect(displayed_project_titles).to eq(expected_project_titles)
  end

  scenario 'by "priority" field with "ascending" order' do
    visit user_projects_path(:en, user)

    select 'Priority', from: 'sort_by'
    select 'Ascending', from: 'order_direction'
    click_button 'Sort'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['project 3', 'project 2', 'project 1']
    expect(displayed_project_titles).to eq(expected_project_titles)
  end
end
