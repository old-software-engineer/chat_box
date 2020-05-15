module ChatBox
  module Helpers
    def chat_section(options={})
      if user_signed_in?
        users = User.where("id != ?", current_user)
        debugger
        conversations = session[:conversations].nil? || session[:conversations].blank? ? [] : Conversation.includes(:recipient, :messages).find(session[:conversations])
        render partial: "chat_box/user/user_list",locals:{conversations: conversations,users: users}
      end
    end
  end
end

class ActionView::Base
  include ChatBox::Helpers
end