FactoryBot.define do
  factory :project do
    sequence :title do |n|
      "Project #{n}"
    end
    sequence :content do |n|
      "Content #{n}"
    end
    created_at { Faker::Time.between_dates(from: Date.today - 10, to: Date.today - 6) }
    start_date { Faker::Time.between_dates(from: Date.today - 5, to: Date.today - 2) }
    due_date { Faker::Time.between_dates(from: Date.today, to: Date.today + 10) }
    status { Project.statuses.values.sample }
    association :user
  end
end
