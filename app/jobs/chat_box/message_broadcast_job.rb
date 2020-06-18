module ChatBox
  class MessageBroadcastJob < ApplicationJob
    queue_as :default

    def perform(message)
      sender = message.user
      recipient = message.conversation.opposed_user(sender)
      if message.conversation.is_conversation
        broadcast_to_sender(sender, message)
        broadcast_to_recipient(recipient, message)
      else
        broadcast_to_group_sender(sender, message)
        group = message.group
        recipient_users = ([group.sender] + group.users).reject{|u| u == sender}
        recipient_users.each{|user|broadcast_to_group_recipient(user, message)}
      end
    end

    def perform_later(i)
      # code here
    end

    private

    def broadcast_to_group_sender(user, message)
      ActionCable.server.broadcast(
          "group-message-#{user.id}",
          message: render_message(message, user),
          group_id: message.conversation_id
      )
    end

    def broadcast_to_group_recipient(user, message)
      ActionCable.server.broadcast(
          "group-message-#{user.id}",
          window: render_group_window(message.group, user),
          message: render_message(message, user),
          group_id: message.conversation_id
      )
    end

    def render_group_window(group, user)
      ApplicationController.render(
          partial: 'chat_box/conversations/group_conversation',
          locals: { group: group, user: user }
      )
    end

    def broadcast_to_sender(user, message)
      ActionCable.server.broadcast(
          "conversations-#{user.id}",
          message: render_message(message, user),
          conversation_id: message.conversation_id
      )
    end

    def broadcast_to_recipient(user, message)
      ActionCable.server.broadcast(
          "conversations-#{user.id}",
          window: render_window(message.conversation, user),
          message: render_message(message, user),
          conversation_id: message.conversation_id
      )
    end

    def render_window(conversation, user)
      ApplicationController.render(
          partial: 'chat_box/conversations/conversation',
          locals: { conversation: conversation, user: user }
      )
    end

    def render_message(message,user)
      ApplicationController.render(
          partial: 'chat_box/messages/message',
          locals: { message: message, user: user }
      )
    end
  end
end