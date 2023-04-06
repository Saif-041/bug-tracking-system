# frozen_string_literal: true

# class User < ApplicationRecord
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :manager_projects, class_name: 'Project', foreign_key: 'id', dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects
  has_many :bugs, dependent: :destroy
  enum :user_types, { Manager:  0, Qa: 1, Developer: 2}, default: :Developer
end
