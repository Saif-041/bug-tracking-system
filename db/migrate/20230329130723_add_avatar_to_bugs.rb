# frozen_string_literal: true

class AddAvatarToBugs < ActiveRecord::Migration[7.0]
  def change
    add_column :bugs, :screenshot, :json
  end
end
