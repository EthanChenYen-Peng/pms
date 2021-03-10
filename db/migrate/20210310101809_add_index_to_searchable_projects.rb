class AddIndexToSearchableProjects < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :projects, :searchable, using: :gin, algorithm: :concurrently
  end
end
