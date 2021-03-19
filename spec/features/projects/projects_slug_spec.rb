require 'rails_helper'

RSpec.feature 'Project URL ' do
  context 'locale: en' do
    let(:user) { FactoryBot.create(:user, username: 'Ethan Chen') }
    let(:project) do
      FactoryBot.create(:project,
                        title: 'Rails PMS',
                        user: user)
    end

    it 'should be composed by username and project slug' do
      login_as(user)
      visit user_project_path(:en, user, project)

      expect(current_path).to eq '/en/users/ethan-chen/projects/rails-pms'
    end
  end
end
