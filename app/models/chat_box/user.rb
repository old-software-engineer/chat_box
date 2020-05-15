module ChatBox
  class User < ApplicationRecord
    has_many :messages,class_name: 'ChatBox::Message'
    has_many :conversations, foreign_key: :sender_id,class_name: 'ChatBox::Conversation'
  end
end