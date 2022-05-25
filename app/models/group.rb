# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :user_group_assignments, dependent: :delete_all
  has_many :users, through: :user_group_assignments
  has_many :tasks, dependent: :delete_all
  has_many :task_instances, through: :tasks

  def current_tasks
    task_instances.filter { |task| !task.complete & task.visible? }.sort_by(&:due_date)
  end
end
