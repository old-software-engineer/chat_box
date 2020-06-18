module ChatBox
  class GroupMessageChannel < ApplicationCable::Channel
    def subscribed
      stream_from "group-message-#{current_user.id}"
    end

    def unsubscribed
      stop_all_streams
    end

    def speak(data)
      message_params = data['message'].each_with_object({}) do |el, hash|
        hash[el.values.first] = el.values.last
      end
      ChatBox::Message.create(message_params)
    end
  end
end