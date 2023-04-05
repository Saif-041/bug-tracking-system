# frozen_string_literal: true

# class Bug < ApplicationRecord
class Bug < ApplicationRecord
  mount_uploader :screenshot, AvatarUploader
  # serialize :screenshot, JSON # If you use SQLite, add this line.

  validates :title, presence: true, uniqueness: true
  validates :bug_status, presence: true
  validates :bug_type, presence: true
  belongs_to :project
  has_many :users, dependent: :destroy
end
