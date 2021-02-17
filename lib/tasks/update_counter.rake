namespace :counters do
  desc 'Update users table counter_cache'
  task update: :environment do
    User.find_each do |user|
      User.reset_counters(user.id, :projects)
    end
  end
end
