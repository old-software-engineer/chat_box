module ChatBox
  class Message < ApplicationRecord
    belongs_to :user, class_name: ChatBox.author_class.to_s
    belongs_to :conversation,foreign_key: 'conversation_id',class_name: "Conversation" #, if: -> { self.conversation.is_conversation}
    # belongs_to :group,foreign_key: 'conversation_id',class_name: "Group", if: -> { !self.conversation.is_conversation}
    validates :body, presence: true
    after_create_commit { ChatBox::MessageBroadcastJob.perform_later(self) }
  end
end
