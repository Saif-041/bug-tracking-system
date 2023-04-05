# frozen_string_literal: true

# This class AddAvatarToBugs < ActiveRecord
class AddAvatarToBugs < ActiveRecord::Migration[7.0]
  def change
    add_column :bugs, :screenshot, :json
  end
end
