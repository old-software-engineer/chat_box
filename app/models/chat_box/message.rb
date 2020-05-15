module ChatBox
  class Message < ApplicationRecord
    belongs_to :user, class_name: '::User'
    belongs_to :conversation,primary_key: :conversation_id,class_name: 'Message'
  end
end