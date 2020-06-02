require "active_support/concern"

module ChatBox
  module UserChat
    extend ActiveSupport::Concern

    included do
      class UserList < self; end
      has_many :messages,class_name: 'ChatBox::Message'
      has_many :conversations, foreign_key: :sender_id,class_name: 'ChatBox::Conversation'
      after_save :update_online_status
    end

    def update_online_status
      ActionCable.server.broadcast(
          "online_users",
          html: render_user_list(self),
          online: self.is_online?,
          id: self.id
      )
    end

    def render_user_list(user)
      ApplicationController.render(
          partial: 'chat_box/user/user',
          locals:{user: user}
      )
    end

    def chat_list
      self.class.where("id NOT IN (?)",[self.id])
    end

  end
end