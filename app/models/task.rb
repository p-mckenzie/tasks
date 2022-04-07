class Task < ApplicationRecord
  belongs_to :group
  has_many :task_instances
  validates :title, presence: true

  before_save :next_task_instance

  def is_recurring?
    recurrence_type != ''
  end

  def next_task_instance
    if task_instances.empty? || (current_instance.complete and is_recurring?)
      task_instances << next_instance
    end
  end

  def current_instance
    task_instances.last
  end

  def next_instance
    case self.recurrence_type
    when "" || nil
      TaskInstance.new(due_date: self.due_date)
    when "Daily"
      TaskInstance.new(due_date: (current_instance ? current_instance.due_date : due_date) + (separation || 0))
    when "Weekly"
      TaskInstance.new(due_date: (current_instance ? current_instance.due_date : due_date) + 7*separation )
    when "Monthly"
      TaskInstance.new(due_date: (current_instance ? current_instance.due_date : due_date) +separation.months )
    when "Yearly"
      TaskInstance.new(due_date: (current_instance ? current_instance.due_date : due_date) +separation.years )
    end
  end

end
