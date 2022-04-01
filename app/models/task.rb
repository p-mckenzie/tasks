class Task < ApplicationRecord
  belongs_to :group
  has_many :task_instances
  validates :title, presence: true

  before_save :next_task_instance

  private
  def next_task_instance
    if self.task_instances.empty? || (current_instance.completed and self.is_recurring)
      holder = next_instance
      self.task_instances << holder
    end
  end

  def current_instance
    self.task_instances.last
  end

  def next_instance
    case self.recurrence_type
    when "" || nil
      TaskInstance.new(due_date: self.due_date)
    when "Daily"
      TaskInstance.new(due_date: (current_instance ? current_instance.due_date : self.due_date) + (self.separation || 0))
    when "Weekly"
      TaskInstance.new(due_date: (current_instance ? current_instance.due_date : self.due_date) + 7*self.separation )
    when "Monthly"
      TaskInstance.new(due_date: (current_instance ? current_instance.due_date : self.due_date) +self.separation.months )
    when "Yearly"
      TaskInstance.new(due_date: (current_instance ? current_instance.due_date : self.due_date) +self.separation.years )
    end
  end

end
