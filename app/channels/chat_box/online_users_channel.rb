module ChatBox
  class OnlineUsersChannel < ApplicationCable::Channel
    def subscribed
      stream_from "online_users"
      if current_user.present?
        current_user.update(is_online: true)
      end
    end

    def unsubscribed
      if current_user.present?
        current_user.update(is_online: false)
      end
    end
  end
end