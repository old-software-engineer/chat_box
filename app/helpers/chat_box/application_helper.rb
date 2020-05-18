module ChatBox
  module ApplicationHelper
    def chat_section
      if user_signed_in?
        @users = User.where("id != ?", current_user)
        conversations = session[:conversations].nil? || session[:conversations].blank? ? [] : Conversation.includes(:recipient, :messages).where(id: session[:conversations])
        render partial: "chat_box/user/user_list",locals:{users: @users,conversations: conversations}
      end
    end
  end
end