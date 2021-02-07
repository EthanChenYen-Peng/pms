class AddSearchIndexToProjects < ActiveRecord::Migration[6.1]
  def change
    add_index :projects, :title, unique: true
  end
end
