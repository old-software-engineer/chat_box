class CreateMessagesTable < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :chat_box_messages do |t|
      t.text :body
      t.references :user, foreign_key: true
      t.references :conversation, foreign_key: true

      t.timestamps
    end
  end
end
