# frozen_string_literal: true

class AddDelayToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :visibility_delay, :integer, default: nil
    add_column :tasks, :repeat_until, :datetime, default: nil
    add_column :tasks, :quantity, :integer, default: nil
  end
end
