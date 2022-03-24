class TaskInstance < ApplicationRecord
  belongs_to :task
  has_one :group, through: :task
  belongs_to :user, optional: true
end
