# frozen_string_literal: true

class Developer < ApplicationRecord
  has_one :user
end