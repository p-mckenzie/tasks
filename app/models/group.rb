class Group < ApplicationRecord
  has_many :user_group_assignments, dependent: :delete_all
  has_many :users, through: :user_group_assignments
  has_many :tasks, dependent: :delete_all
  has_many :task_instances, through: :tasks, dependent: :delete_all

  def current_tasks
    task_instances.filter {|task| !task.complete }.sort_by {|task| task.due_date }
  end
end
