# frozen_string_literal: true

# class User < ApplicationRecord
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, inverse_of: :user

  has_many :manager_projects, class_name: 'Project', foreign_key: 'id', dependent: :destroy, inverse_of: :user
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects
  has_many :bugs, dependent: :destroy
end
