class @ConversationsList extends React.Component
  render: ->
    conversations = this.props.conversations.map (conversation) ->
      `<ConversationsListRow conversation={conversation}/>`

    `<div className="list-group">{conversations}</div>`
