# == Schema Information
#
# Table name: conversations
#
#  id             :integer          not null, primary key
#  first_user_id  :integer
#  second_user_id :integer
#

class Conversation < ApplicationRecord
  belongs_to :first_user, class_name: 'User'
  belongs_to :second_user, class_name: 'User'
  has_many :messages, inverse_of: :conversation
  
  validates :first_user_id, :second_user_id, presence: true
  validate :validate_companion
  
  def self.for_users(first_user, second_user)
    first_user_id, second_user_id = first_user.try(:id), second_user.try(:id)
    direct_condition = { first_user_id: first_user_id, second_user_id: second_user_id }
    reversed_condition = { first_user_id: second_user_id, second_user_id: first_user_id }
    where(direct_condition).or(where(reversed_condition)).first or create(direct_condition)
  end
  
  def self.for_user(user)
    where(first_user_id: user.id).or(where(second_user_id: user.id))
  end

  def companion(user)
    second_user == user ? first_user : second_user
  end
  
  def validate_companion
    if first_user_id == second_user_id
      errors.add(:second_user, 'You cannot write to yourself')
      self.second_user = nil
    end
  end
  
  def new_messages_count(user)
    messages.where(is_read: false, receiver_id: user.try(:id)).count
  end
end
