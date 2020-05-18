class CreateMessagesTable < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :chat_box_messages do |t|
      t.text :body
      t.belongs_to :user, foreign_key: true
      t.belongs_to :conversation

      t.timestamps
    end
  end
end
