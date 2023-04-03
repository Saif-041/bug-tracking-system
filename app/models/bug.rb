class Bug < ApplicationRecord
    # mount_uploaders :screenshot, AvatarUploader
    mount_uploader :screenshot, AvatarUploader
    # serialize :screenshot, JSON # If you use SQLite, add this line.

    validates :title, presence: true, uniqueness: true
    validates :bug_status, presence: true
    validates :bug_type, presence: true
    

    belongs_to :project
    
    # belongs_to :user
    has_many :users
end