class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.integer :first_user_id
      t.integer :second_user_id
      t.timestamps
    end
    
    add_index :conversations, :first_user_id
    add_index :conversations, :second_user_id
  end
end
