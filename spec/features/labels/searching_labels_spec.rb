require 'rails_helper'

RSpec.feature 'Users can search for projects by labels' do
  let(:user) { FactoryBot.create(:user) }

  before do
    label_1 = FactoryBot.create(:label, name: 'React')
    FactoryBot.create(:project, user: user, title: 'React blog', labels: [label_1])
    label_2 = FactoryBot.create(:label, name: 'Vue')
    FactoryBot.create(:project, user: user, title: 'Vue task management app', labels: [label_2])
    login_as(user)
    visit projects_path(locale: :en)
  end

  scenario 'searching by label' do
    fill_in 'Labels', with: 'React'
    click_button 'Search'

    expect(page).to have_content 'React blog'
    expect(page).to_not have_content 'Vue task management app'
  end

  scenario 'searching multiple labels at once' do
    fill_in 'Labels', with: 'React, Vue'
    click_button 'Search'

    expect(page).to have_content 'React blog'
    expect(page).to have_content 'Vue task management app'
  end

  scenario 'searching with  label that is attached to any project' do
    fill_in 'Labels', with: 'IceCream'
    click_button 'Search'

    expect(page).to_not have_content 'React blog'
    expect(page).to_not have_content 'Vue task management app'
  end
end
