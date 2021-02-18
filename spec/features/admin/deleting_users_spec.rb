require 'rails_helper'

RSpec.feature 'As an admin, I can delete user account' do
  scenario 'deleting regular user account' do
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

  scenario 'deleting myself when there are other admins' do
    FactoryBot.create(:user, admin: true)
    admin = FactoryBot.create(:user, admin: true)
    login_as(admin)

    click_on 'Admin'
    click_on 'Users'
    click_on admin.email
    click_on 'Delete'

    expect(page).to have_content 'You are not authorized to access this page.'
    expect(current_path).to eq(root_path)
  end

  scenario 'deleting myself when I am the only admin should fail' do
    admin = FactoryBot.create(:user, admin: true)
    login_as(admin)

    click_on 'Admin'
    click_on 'Users'
    click_on admin.email
    click_on 'Delete'

    expect(page).to have_content 'Account has not been deleted.'
    expect(page).to have_content 'Cannot delete the only remaining admin account.'
  end
end
