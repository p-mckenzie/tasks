class AddAdminFieldToUserAssignments < ActiveRecord::Migration[6.1]
  def change
    add_column :user_group_assignments, :admin, :boolean, default: false
    add_foreign_key :user_group_assignments, :users, on_delete: :cascade
    add_foreign_key :user_group_assignments, :groups, on_delete: :cascade
  end
end
