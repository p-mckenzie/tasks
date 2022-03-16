class User < ApplicationRecord
  has_many :user_group_assignments
  has_many :groups, through: :user_group_assignments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
