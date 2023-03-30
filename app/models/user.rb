class User < ApplicationRecord
  # before_action :authenticate_user!

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # belongs_to :project

  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects

  has_many :bugs
end
