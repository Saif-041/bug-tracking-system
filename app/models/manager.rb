# frozen_string_literal: true

class Manager < ApplicationRecord
  has_one :user
  has_many :projects
end