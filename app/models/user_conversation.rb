# == Schema Information
#
# Table name: user_conversations
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  conversation_id :integer
#  visited_at      :datetime
#

class UserConversation < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
end
