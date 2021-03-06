class UpdateSearchIndexToProjects < ActiveRecord::Migration[6.1]
  def change
    remove_index :projects, :title
    add_index :projects, [:title, :user_id], unique: true
  end
end
