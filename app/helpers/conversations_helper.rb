module ConversationsHelper
  def conversations_react_params(conversations)
    conversations.map do |conversation|
      { id: conversation.id,
        messages_url: conversation_messages_path(conversation),
        new_messages_count: conversation.new_messages_count(current_user),
        user_email: conversation.companion(current_user).email }
    end
  end
end
