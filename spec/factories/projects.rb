FactoryBot.define do
  factory :project do
    title { Faker::Name.unique.name }
    content { Faker::Lorem.sentence }
    created_at { Faker::Time.between_dates(from: Date.today - 10, to: Date.today - 6) }
    start_date { Faker::Time.between_dates(from: Date.today - 5, to: Date.today - 2) }
    due_date { Faker::Time.between_dates(from: Date.today, to: Date.today + 10) }
  end
end
