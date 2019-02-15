class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string, null: false, default: 'user'
    remove_column :users, :admin, :boolean
  end
end
