class AddDelayToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :visibility_delay, :integer, default: nil
  end
end
