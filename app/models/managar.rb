# frozen_string_literal: true

class Managar < User
  has_one :user
  has_many :projects
end