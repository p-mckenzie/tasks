# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.date :due_date, null: false

      t.string :recurrence_type, default: ''
      t.integer :separation

      t.timestamps

      t.references :group, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
    end
  end
end
