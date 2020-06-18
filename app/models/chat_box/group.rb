module ChatBox
	class Group < Conversation
		clear_validators!
		belongs_to :sender, foreign_key: :sender_id, class_name:  ChatBox.author_class.to_s
		has_many :messages,foreign_key: :conversation_id, dependent: :destroy,class_name: "Message"
		validates :group_name,:group_ids, presence: true,  if: -> { self.recipient_id.nil?}
		
		default_scope ->{where("group_name IS NOT NULL AND group_ids IS NOT NULL")}
		after_save :update_group_to_users,  if: -> { self.recipient_id.nil?}

		# def is_group
		# 	recipient_id.nil? && !group_name.nil? && !JSON.parse(self.group_ids).blank?
		# end

		def users
			ChatBox.author_class.find(JSON.parse(self.group_ids))
		end

		private

		def update_group_to_users
			user_ids = [self.sender_id] + JSON.parse(self.group_ids)
			user_ids.each{|id| update_online_status(id)}
		end

		def update_online_status(id)
	      ActionCable.server.broadcast(
	          "group-conversations-#{id}",
	          html: render_user_list(self),
	          'group-id': self.id
	      )
	    end


	    def render_user_list(group)
	      ApplicationController.render(
	          partial: 'chat_box/conversations/group',
	          locals:{group: group}
	      )
	    end
	end
end