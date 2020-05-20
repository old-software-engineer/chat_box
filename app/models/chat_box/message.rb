module ChatBox
  class Message < ApplicationRecord
    belongs_to :user, class_name: '::User'
    belongs_to :conversation

    after_create_commit { ChatBox::MessageBroadcastJob.perform_later(self) }
  end
end
