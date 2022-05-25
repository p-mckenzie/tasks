# frozen_string_literal: true

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

  def admin?(group)
    mapping = user_group_assignments.where({ group_id: group.id }).first
    mapping ? mapping.admin : false
  end

  def current_tasks
    task_instances.filter do |task|
      !task.complete & task.visible? & (task.user_id == id)
    end.sort_by(&:due_date)
  end
end
