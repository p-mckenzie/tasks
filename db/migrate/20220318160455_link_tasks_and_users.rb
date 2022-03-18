class LinkTasksAndUsers < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :task_instances, :tasks, on_delete: :cascade
    add_foreign_key :tasks, :groups, on_delete: :cascade
  end
end
