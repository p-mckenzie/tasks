class User < ApplicationRecord
  has_many :user_group_assignments, dependent: :delete_all
  has_many :groups, through: :user_group_assignments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_admin?(group)
    mapping = self.user_group_assignments.where({group_id: group.id}).first
    return mapping ? mapping.admin : false
  end
end
