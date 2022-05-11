class Task < ApplicationRecord
  belongs_to :group
  belongs_to :user, optional: true
  has_many :task_instances
  validates :title, presence: true

  before_save :next_task_instance

  def is_recurring?
    recurrence_type != ''
  end

  def next_task_instance
    new_task_instance = next_instance
    if (repeat_until ? (next_task_instance.due_date > repeat_until) : false) || (quantity ? (completed_instances.count >= quantity) : false)
      return
    else
      new_task_instance.user = self.user
      task_instances << new_task_instance
    end
  end

  def current_instance
    task_instances.last
  end

  def completed_instances
    task_instances.filter(&:complete).sort_by(&:due_date).reverse!
  end

  private

  def next_instance
    next_due_date = (current_instance ? current_instance.due_date : due_date) + date_offset
    TaskInstance.new(due_date: next_due_date, user: user)
  end

  def date_offset
    case self.recurrence_type
    when "" || nil
      0
    when "Daily"
      (separation || 0)
    when "Weekly"
      7*separation
    when "Monthly"
      separation.months
    when "Yearly"
      separation.years
    end
  end

end
