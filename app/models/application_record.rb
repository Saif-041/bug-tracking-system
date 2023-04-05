# frozen_string_literal: true

# class ApplicationRecord < ActiveRecord::Base
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def manager?
    user_type == 'Manager'
  end

  def qa?
    user_type == 'QA'
  end

  def developer?
    user_type == 'Developer'
  end
end
