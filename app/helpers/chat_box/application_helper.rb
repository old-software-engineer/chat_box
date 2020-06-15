module ChatBox
  module ApplicationHelper
    def chat_section(option={})
    	option[:title] = option[:title] || "Chat List"
      if user_signed_in?
        users = current_user.chat_list
        conversations = session[:conversations].nil? || session[:conversations].blank? ? [] : Conversation.includes(:recipient, :messages).where(id: session[:conversations])
        render partial: "chat_box/user/user_list",locals:{users: users,conversations: conversations,option: option}
      end
    end
  end
end