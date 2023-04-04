# frozen_string_literal: true

class Project < ApplicationRecord
  validates :name, presence: true
  belongs_to :managar

  has_many :bugs
  # accepts_nested_attributes_for :bugs
    
  has_many :user_projects
  has_many :users, through: :user_projects

end