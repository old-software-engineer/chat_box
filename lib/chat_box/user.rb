require "active_support/concern"

module ChatBox
  module User
    extend ActiveSupport::Concern
    included do
      debugger
      has_many :messages,class_name: 'ChatBox::Message'
      has_many :conversations, foreign_key: :sender_id,class_name: 'ChatBox::Conversation'
    end
  end
end