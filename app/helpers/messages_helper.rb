module MessagesHelper
  def messages_react_params(messages, recent: false)
    messages_params = messages.map do |message|
      { id: message.id,
        sender: message.sender.email,
        created_at: I18n.l(message.created_at, format: :short),
        text: message.text,
        type: current_user == message.sender ? 'outgoing' : 'incoming',
        is_read: message.is_read?,
        mark_read_path: mark_read_conversation_message_path(message.conversation, message),
        reply_path: conversation_messages_path(message.conversation.id)
      }
    end
    
    react_params = { messages: messages_params, recent: recent }
    first_id = messages.first.try(:id)
    last_id = messages.last.try(:id)
    
    if recent
      react_params.merge!({
        load_new_path: unread_messages_path(last_id: first_id, format: :json)
      })
    else
      react_params.merge!({
        load_more_path: conversation_messages_path(params[:conversation_id], oldest_id: last_id, format: :json),
        load_new_path: conversation_messages_path(params[:conversation_id], last_id: last_id, format: :json),
        create_message_path: conversation_messages_path(params[:conversation_id], last_id: last_id, format: :json)
      })
    end
                     
    react_params.deep_transform_keys! { |c| c.to_s.camelcase(:lower).to_sym }
  end
end
