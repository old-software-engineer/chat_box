module ChatBox
  class Message < ApplicationRecord
    belongs_to :user, class_name: '::User'
    belongs_to :conversation
  end
end
