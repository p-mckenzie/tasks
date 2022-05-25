# frozen_string_literal: true

class CreateUserGroupAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :user_group_assignments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
