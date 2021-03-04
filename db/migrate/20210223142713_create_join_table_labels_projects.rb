class CreateJoinTableLabelsProjects < ActiveRecord::Migration[6.1]
  def change
    create_join_table :labels, :projects do |t|
      t.index [:label_id, :project_id], unique: true
      t.index [:project_id, :label_id]
    end
  end
end
