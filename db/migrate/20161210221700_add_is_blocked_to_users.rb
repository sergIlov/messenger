class AddIsBlockedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_blocked, :boolean, default: false
    add_index :users, :is_blocked
  end
end
