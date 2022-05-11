class User < ApplicationRecord
  has_many :user_group_assignments, dependent: :delete_all
  has_many :groups, through: :user_group_assignments
  has_many :tasks, through: :groups
  has_many :task_instances, through: :tasks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_admin?(group)
    mapping = self.user_group_assignments.where({group_id: group.id}).first
    return mapping ? mapping.admin : false
  end

  def current_tasks
    task_instances.filter {|task| !task.complete & task.visible? & (task.user_id==id) }.sort_by {|task| task.due_date }
  end

end
