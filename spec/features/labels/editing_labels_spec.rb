require 'rails_helper'

RSpec.feature 'Users can edit existing labels' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:label) { FactoryBot.create(:label, user: user) }

  before do
    login_as(user)
    visit labels_path
    within "#edit-btn-#{label.id}" do
      click_link 'Edit'
    end
  end

  scenario 'with valid inputs' do
    fill_in 'label[name]', with: 'Doing'
    click_button 'Update Label'

    expect(page).to have_content 'Label has been updated.'
  end

  scenario 'when user already has a label with the same name should fail' do
    FactoryBot.create(:label, name: 'Todo', user: user)

    fill_in 'label[name]', with: 'Todo'
    click_button 'Update Label'

    expect(page).to have_content 'Label has not been updated.'
    expect(page).to have_content 'You already have a label with the same name.'
  end
end
