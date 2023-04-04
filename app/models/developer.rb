# frozen_string_literal: true

class Developer < ApplicationRecord
  has_many :projects
  has_one :user
end