module ChatBox
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception

    # before_action Chat.logged_in_check
  end
end