# frozen_string_literal: true

class CreateTaskInstance < ActiveRecord::Migration[6.1]
  def change
    create_table :task_instances do |t|
      t.text :notes
      t.date :due_date, null: false
      t.boolean :complete, default: false

      t.timestamps

      t.references :task, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
    end
  end
end
