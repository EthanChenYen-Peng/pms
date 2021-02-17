require 'rails_helper'

RSpec.feature 'As an admin, I can delete user account' do
  scenario 'successfully' do
    FactoryBot.create(:user, email: 'ethan@gmail.com')
    admin = FactoryBot.create(:user, admin: true)
    user = FactoryBot.create(:user)
    login_as(admin)

    click_on 'Admin'
    click_on 'Users'
    click_on user.email
    click_on 'Delete'

    expect(page).to have_content 'Account has been deleted.'
    expect(page).to_not have_content user.email
  end
end
