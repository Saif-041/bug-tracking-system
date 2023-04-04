# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # belongs_to :project

  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects

  has_many :bugs
  # , foreign_key: :assign_id
end
