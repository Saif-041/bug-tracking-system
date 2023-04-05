# frozen_string_literal: true

# This class CreateBugs < ActiveRecord
class CreateBugs < ActiveRecord::Migration[7.0]
  def change
    create_table :bugs do |t|
      t.text :title
      t.string :description
      t.date :deadline
      t.string :bug_status, default: 'New'
      t.string :bug_type
      t.references :assign, foreign_key: { to_table: :users }
      t.references :created, foreign_key: { to_table: :users }
      t.integer :project_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
