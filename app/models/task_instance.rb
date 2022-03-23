class TaskInstance < ApplicationRecord
  belongs_to :task
  belongs_to :user, optional: true
end
