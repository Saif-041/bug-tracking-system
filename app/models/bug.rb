class Bug < ApplicationRecord

    validates :title, presence: true
    validates :status, presence: true
    validates :type, presence: true
    

    belongs_to :project
    
    belongs_to :user
    has_many :users
end