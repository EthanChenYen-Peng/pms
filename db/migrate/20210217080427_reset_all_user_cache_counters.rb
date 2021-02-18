class ResetAllUserCacheCounters < ActiveRecord::Migration[6.1]
  def change
    User.all.each do |user|
      User.reset_counters(user.id, :projects)
    end
  end
end
