require 'rails_helper'

RSpec.describe User, type: :model do
  it 'username and email should be unique' do
    User.create(username: 'Ethan', email: 'ethan@gmail.com', password: 'asdf')
    user = User.new(username: 'Ethan', email: 'ethan@gmail.com', password: 'adsf')
    user.save

    expect(user.errors.any?).to be(true)
    expect(user.errors[:username]).to match_array(['has already been taken'])
    expect(user.errors[:email]).to match_array(['has already been taken'])
  end
end
