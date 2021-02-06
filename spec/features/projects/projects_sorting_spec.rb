require 'rails_helper'

RSpec.feature 'Projects can searched and filetered' do
  before :each do
    Project.delete_all
    names = ['Dr. Bradly Monahan', 'Rep. Gertrudis Schaefer', 'Zachary Nader', 'Efrain Gulgowski PhD', 'Jaime Stehr',
             'Man Mayert', 'Williemae Denesik', 'Will Beer', 'Cecil Williamson', 'Jerrod Howell', 'Jefferson Murphy', 'Luigi Wolf', 'Vernon Pouros', 'Grover Considine', 'Jimmie Wilkinson']

    names.each do |name|
      FactoryBot.create(:project, title: name)
    end
  end
  scenario 'search with only lowercase' do
    visit projects_path

    fill_in 'search_title', with: 'wil'
    click_button 'Search'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['Cecil Williamson', 'Jimmie Wilkinson', 'Will Beer', 'Williemae Denesik']
    expect(displayed_project_titles).to match_array(expected_project_titles)
  end

  scenario 'search with only uppercase letter' do
    visit projects_path

    fill_in 'search_title', with: 'WIL'
    click_button 'Search'

    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = ['Cecil Williamson', 'Jimmie Wilkinson', 'Will Beer', 'Williemae Denesik']
    expect(displayed_project_titles).to match_array(expected_project_titles)
  end
end
