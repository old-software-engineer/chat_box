class CreateConversationsTable < ActiveRecord::Migration<%= migration_version %>
  def self.up
    create_table :chat_box_conversations do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.text    :group_name
      t.text   :group_id, array: true,default: [].to_yaml
      t.timestamps
    end
    add_index :chat_box_conversations, [:recipient_id, :sender_id], unique: true
  end

  def self.down
    drop_table :chat_box_conversations
  end
end