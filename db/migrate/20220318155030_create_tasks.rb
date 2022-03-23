class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.date :due_date, null: false

      t.boolean :is_recurring, default: false
      t.string :recurrence_type
      t.integer :separation

      t.timestamps

      t.references :group, null: false, foreign_key: true
    end
  end
end
