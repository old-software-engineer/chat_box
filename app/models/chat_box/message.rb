module ChatBox
  class Message < ApplicationRecord
    belongs_to :user, class_name: ChatBox.author_class.to_s
    belongs_to :conversation

    after_create_commit { ChatBox::MessageBroadcastJob.perform_later(self) }
  end
end
