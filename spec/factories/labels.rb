FactoryBot.define do
  factory :label do
    name { Faker::Name.first_name }
    association :user
  end
end
