module ChatBox
  module ApplicationHelper
    def chat_section
      if user_signed_in?
        @users = User.where("id != ?", current_user)
        # debugger
        conversations = session[:conversations].nil? || session[:conversations].blank? ? [] : Conversation.includes(:recipient, :messages).find(session[:conversations])
        render partial: "chat_box/user/user_list",locals:{users: @users,conversations: conversations}
      end
    end
  end
end