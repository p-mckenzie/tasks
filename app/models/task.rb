class Task < ApplicationRecord
  belongs_to :group
  has_many :task_instances

  def next_task_instance
    if self.task_instances.empty?
      self.task_instances << TaskInstance.new(due_date: self.due_date)
    elsif current_instance.completed and self.is_recurring
      self.task_instances << TaskInstance.new(due_date: current_instance.due_date + self.separation)
    else
      raise "Don't need another"
    end

  end

  def current_instance
    self.task_instances.last
  end
end
