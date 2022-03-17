class AddAdminFieldToUserAssignments < ActiveRecord::Migration[6.1]
  def change
    add_column :user_group_assignments, :admin, :boolean, default: false
  end
end
