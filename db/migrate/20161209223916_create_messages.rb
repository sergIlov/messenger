class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id
      t.integer :conversation_id, null: false
      t.boolean :is_read, default: false
      t.text :text
      t.timestamps
    end
    
    add_index :messages, :is_read
    add_index :messages, :receiver_id
  end
end
