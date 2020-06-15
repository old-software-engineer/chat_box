module ChatBox
	class Group < Conversation
		belongs_to :sender, foreign_key: :sender_id, class_name:  ChatBox.author_class.to_s
		has_many :messages,foreign_key: :conversation_id, dependent: :destroy,class_name: "Message"
		validates :group_name, presence: true
		default_scope ->{where("group_name IS NOT NULL AND group_ids IS NOT NULL")}

		def users
			ChatBox.author_class.find(JSON.parse(self.group_ids))
		end
	end
end