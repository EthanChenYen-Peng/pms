require 'rails_helper'

RSpec.feature 'Projects can be searched by title and content' do
  let(:user) { FactoryBot.create(:user) }

  before :each do
    project_titles = ['Dr. Bradly Monahan', 'Luigi Wolf',
                      'Vernon Pouros', 'Grover Considine',
                      'Jimmie Wilkinson', 'react tutorial',
                      'Rails PMS', 'Rails Blog', 'Rails & React chat app']
    login_as(user)
    project_titles.each do |title|
      FactoryBot.create(:project, title: title, user: user)
    end
  end
  scenario 'search with only lowercase' do
    visit user_projects_path(:en, user)

    fill_in 'search', with: 'rails'
    click_button 'Search'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['Rails PMS', 'Rails Blog', 'Rails & React chat app']
    expect(displayed_project_titles).to match_array(expected_project_titles)
  end

  scenario 'search with only uppercase letter' do
    visit user_projects_path(:en, user)

    fill_in 'search', with: 'RAILS'
    click_button 'Search'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['Rails PMS', 'Rails Blog', 'Rails & React chat app']
    expect(displayed_project_titles).to match_array(expected_project_titles)
  end
end
