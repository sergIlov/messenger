# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  sender_id       :integer          not null
#  receiver_id     :integer
#  conversation_id :integer          not null
#  text            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_read         :boolean          default("false")
#

class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :conversation, inverse_of: :messages, touch: true
  
  validates :text, :sender, :receiver, :conversation, presence: true
  
  default_scope proc { order(created_at: :desc) }
  scope :unread, proc { where(is_read: false) }
  
  def is_new_for?(user)
    !is_read && user != sender
  end
end
