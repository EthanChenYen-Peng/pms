require 'pry'
require 'rails_helper'

RSpec.feature 'Projects are sorted' do
  scenario 'by "created_at" field"' do
    projects = []
    10.times do
      projects << FactoryBot.create(:project)
    end

    visit root_path
    displayed_project_titles = page.find_all('.project-title').map(&:text)
    expected_project_titles = projects.sort_by(&:created_at).reverse.map(&:title)
    expect(displayed_project_titles).to eq(expected_project_titles)
  end
end
