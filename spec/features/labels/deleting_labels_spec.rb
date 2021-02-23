require 'pry'
require 'rails_helper'

RSpec.feature 'Users can delete existing labels' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:label) { FactoryBot.create(:label, name: 'Todo', user: user) }

  before do
    5.times do 
      FactoryBot.create(:label, user: user)
    end
    login_as(user)
    visit labels_path
  end

  scenario 'successfully' do
    within "#delete-btn-#{label.id}" do
      click_link 'Delete'
    end

    expect(page).to have_content 'Label has been deleted.'
    expect(page).to_not have_content 'Todo'
  end

end
