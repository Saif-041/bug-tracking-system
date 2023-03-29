class CreateBugs < ActiveRecord::Migration[7.0]
  def change
    create_table :bugs do |t|
      t.text :title
      t.string :description
      t.datetime :deadline
      t.string :status, default: 'New'
      t.string :type
      t.integer :assign_id, null: false, foreign_key: true
      t.integer :created_id, null: false, foreign_key: true
      t.integer :project_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
