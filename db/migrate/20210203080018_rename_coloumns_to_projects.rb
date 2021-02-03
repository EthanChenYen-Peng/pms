class RenameColoumnsToProjects < ActiveRecord::Migration[6.1]
  def change
    rename_column :projects, :end_at, :due_date
    rename_column :projects, :start_at, :start_date
  end
end
