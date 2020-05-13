module ChatBox
  class Message < ApplicationRecord
    belongs_to :user
    belongs_to :conversation
  end
end