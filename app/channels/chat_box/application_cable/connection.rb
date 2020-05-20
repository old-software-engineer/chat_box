module ChatBox
  module ApplicationCable
    class Connection < ActionCable::Connection::Base
      identified_by :current_user

      def connect
        debugger
        self.current_user = find_verified_user
      end

      protected

      def find_verified_user
        debugger
        if (current_user = env['warden'].user)
          current_user
        else
          reject_unauthorized_connection
        end
      end
    end
  end
end
