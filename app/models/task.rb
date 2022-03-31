class Task < ApplicationRecord
  belongs_to :group
  has_many :task_instances

  before_create :next_task_instance

  private
  def next_task_instance
    if self.task_instances.empty? || (current_instance.completed and self.is_recurring)
      self.task_instances << next_instance
    end
  end

  def current_instance
    self.task_instances.last
  end

  def next_instance
    case self.recurrence_type
    when ""
      TaskInstance.new(due_date: self.due_date)
    when "daily"
      TaskInstance.new(due_date: (current_instance.due_date || self.due_date) + (self.separation || 0))
    when "weekly"
      TaskInstance.new(due_date: ((7-(current_instance.due_date || self.due_date).wday) - (7-self.day_of_week))%7 + 7*self.separation )
    when "monthly"
      #TODO
      TaskInstance.new(due_date: self.due_date)
    when "yearly"
      #TODO
      TaskInstance.new(due_date: self.due_date)
    else
      raise "Not valid"
    end
  end
end
