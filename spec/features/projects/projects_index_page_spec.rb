require 'rails_helper'

RSpec.describe 'Project index page' do
  scenario "need to login in order to view that page" do
    visit projects_path

    expect(page).to have_content 'You need to login first.'
  end
end
