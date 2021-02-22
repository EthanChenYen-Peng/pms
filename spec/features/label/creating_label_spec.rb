require 'rails_helper'

RSpec.feature 'As a user' do
  scenario 'I can create labels' do
      user = FactoryBot.create(:user)
      login_as(user)

      click_on 'New Label'
  end
end
