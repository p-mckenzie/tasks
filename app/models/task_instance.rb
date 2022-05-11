class TaskInstance < ApplicationRecord
  belongs_to :task
  has_one :group, through: :task
  belongs_to :user, optional: true

  def on_time?
    complete ? due_date >= updated_at.to_date : false
  end

  def visible?
    if task.visibility_delay
      (due_date - Date.today).to_i <= task.visibility_delay
    else
      true
    end
  end
end
