class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :content
      t.timestamp :start_at
      t.timestamp :end_at

      t.timestamps
    end
  end
end
