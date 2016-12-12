module ConversationsHelper
  def conversations_list_react_params(conversations)
    { conversations: conversations.map do |conversation|
      { id: conversation.id,
        messages_url: conversation_messages_path(conversation),
        new_messages_count: conversation.new_messages_count(current_user),
        user_email: conversation.companion(current_user).email }
    end,
      load_more_path: conversations_path(offset: params[:offset].to_i + conversations.size, format: :json),
      total_count: current_user.conversations.count
    }.deep_transform_keys! { |c| c.to_s.camelcase(:lower).to_sym }
  end
end
