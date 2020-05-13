module ChatBox
  module Helpers
    def chat_section(options={})
      if user_signed_in?
        users = User.where("id != ?", current_user)
        render partial: "chat_box/user/user_list",locals:{users: users}
      end

    end
  end
end

class ActionView::Base
  include ChatBox::Helpers
end