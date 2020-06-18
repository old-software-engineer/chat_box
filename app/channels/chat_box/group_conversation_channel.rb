module ChatBox
  class GroupConversationChannel < ApplicationCable::Channel
    def subscribed
      stream_from "group-conversations-#{current_user.id}"
    end

    def unsubscribed
      stop_all_streams
    end
  end
end