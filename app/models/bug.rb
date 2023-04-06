# frozen_string_literal: true

# class Bug < ApplicationRecord
class Bug < ApplicationRecord
  mount_uploader :screenshot, AvatarUploader
  # serialize :screenshot, JSON # If you use SQLite, add this line.

  belongs_to :project
  validates :title, presence: true, uniqueness: { scope: :project_id, case_sensitive: false }

  FEATURE_STATUS_OPTIONS = %w(New Started Completed)
  BUG_STATUS_OPTIONS = %w(New Started Resolved)

  validate :custom_validation, on: [:create, :update]
  
  validates :bug_type, presence: true
  belongs_to :solver, class_name: 'User', foreign_key: 'assign_id', dependent: :destroy
  belongs_to :creator, class_name: 'User', foreign_key: 'created_id', dependent: :destroy

  scope :bugs, -> { where(bug_type: 'Bug') }
  scope :features, -> { where(bug_type: 'Feature') }

  def self.m_bugs
    where(bug_type: 'Bug')
  end

  def self.m_features
    where(bug_type: 'Feature')
  end

  private 
  def custom_validation
    if (bug_type == "Bug")
      unless BUG_STATUS_OPTIONS.include?(bug_status)
        flash[:danger] = "Invalid Bug Status."
        render 'bugs/new'
      end
    else
      unless FEATURE_STATUS_OPTIONS.include?(bug_status)
        flash[:danger] = "Invalid Bug Status."
        render 'bugs/new'
      end
    end
  end
end
