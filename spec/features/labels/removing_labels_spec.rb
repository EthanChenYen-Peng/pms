require 'rails_helper'

RSpec.feature 'Users can remove labels from a project', js: true do
  let(:user) { FactoryBot.create(:user) }
  let(:label) { FactoryBot.create(:label, name: 'To be deleted') }
  let(:project) do
    FactoryBot.create(:project, user: user, labels: [label])
  end

  before do
    login_as(user)
    visit project_path(locale: :en, id: project.id)
  end

  scenario 'successfully' do

    within "#remove-label-btn-#{label.id}" do
      click_link 'Remove label'
    end

    expect(page).to_not have_content 'To be deleted'
  end
end
