require 'pry'
require 'rails_helper'

RSpec.describe User, type: :model do
  it 'username and email should be unique' do
    User.create(username: 'Ethan', email: 'ethan@gmail.com', password: 'asdf')
    user = FactoryBot.build(:user, username: 'Ethan')
    user.save

    expect(user.errors.any?).to be(true)
    expect(user.errors[:username]).to match_array(['has already been taken'])
  end

  it 'email should be unique' do
    User.create(username: 'Ethan', email: 'ethan@gmail.com', password: 'asdf')
    user = FactoryBot.build(:user, email: 'ethan@gmail.com')
    user.save

    expect(user.errors.any?).to be(true)
    expect(user.errors[:email]).to match_array(['has already been taken'])
  end

  it 'email should be of the right format' do
    user = User.new(username: 'Ethan', email: 'ethangmail.com', password: 'asdf')
    user.save

    expect(user.errors.any?).to be(true)
    expect(user.errors[:email]).to match_array(['is invalid'])
  end

  it 'email unique validation should be case-sensitive' do
    user = User.create(username: 'Ethan', email: 'ethan@gmail.com', password: 'asdf')
    user2 = FactoryBot.build(:user, email: user.email.upcase)
    user2.save

    expect(user2.errors.any?).to be(true)
  end

  it 'email should be saved as lower-case' do
    email_uppercase = 'ETHAN@GMAIL.COM'
    user = FactoryBot.create(:user, email: email_uppercase)
    user.save

    expect(user.email).to eq('ethan@gmail.com')
  end

  it 'should delete all its projects once it is being deleted' do
    user = FactoryBot.create(:user)
    5.times do
      FactoryBot.create(:project, user: user)
    end

    projects = user.projects.all
    user.destroy

    projects.each do |project|
      expect(Project.find_by(id: project.id)).to eq([])
    end
  end
end
