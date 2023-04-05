# frozen_string_literal: true

# This class CreateProjects < ActiveRecord
class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :user_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
