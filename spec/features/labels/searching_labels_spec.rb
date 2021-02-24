require 'rails_helper'

RSpec.feature 'Users can search for projects by labels' do
  let(:user) { FactoryBot.create(:user) }
  let!(:project_1) do
    label = FactoryBot.create(:label, name: 'React')
    FactoryBot.create(:project, title: 'React blog', labels: [label])
  end
  let!(:project_2) do
    label = FactoryBot.create(:label, name: 'Vue')
    FactoryBot.create(:project, title: 'Vue task management app', labels: [label])
  end

  before do
    login_as(user)
    visit projects_path
  end

  scenario 'searching by label' do
    fill_in 'Labels', with: 'blogging, ROR'
    fill_in 'search_title', with: 'wil'
    click_button 'Search'

    expect(page).to have_content 'React blog'
    expect(page).to_not have_content 'Vue task management app'
  end
end
