require "active_support/concern"

module ChatBox
  module UserChat
    extend ActiveSupport::Concern
    included do
      class User < self
        
      end
      has_many :messages,class_name: 'ChatBox::Message'
      has_many :conversations, foreign_key: :sender_id,class_name: 'ChatBox::Conversation'
    end

    def chat_list
      self.class.where("id NOT IN (?)",[self.id])
    end
  end
end