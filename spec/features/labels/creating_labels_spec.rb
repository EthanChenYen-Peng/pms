require 'rails_helper'

RSpec.feature 'Users can create new labels' do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
    visit new_label_path
  end

  scenario 'with valid inputs' do

    fill_in 'label[name]', with: 'Todo'
    click_button 'Create Label'

    expect(page).to have_content 'Label has been created.'
  end

  scenario 'when user already has a label with the same name' do
    FactoryBot.create(:label, name: 'Todo', user: user)

    fill_in 'label[name]', with: 'Todo'
    click_button 'Create Label'

    expect(page).to have_content 'Label has not been created.'
    expect(page).to have_content 'You already have a label with the same name.'
  end
end
