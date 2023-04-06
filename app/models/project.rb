# frozen_string_literal: true

# class Project < ApplicationRecord
class Project < ApplicationRecord
  validates :name, presence: true
  belongs_to :manager, class_name: 'User', foreign_key: 'user_id'

  has_many :bugs, dependent: :destroy

  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
end
