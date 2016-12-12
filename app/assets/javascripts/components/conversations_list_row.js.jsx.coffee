@ConversationsListRow = React.createClass
  getInitialState: ->
    conversation: @props.conversation

  render: ->
    `<a className="list-group-item list-group-item-action" href={this.state.conversation.messagesUrl}>
      <span className="right">{this.state.conversation.newMessagesCount}</span>
      {this.state.conversation.userEmail}
    </a>`
