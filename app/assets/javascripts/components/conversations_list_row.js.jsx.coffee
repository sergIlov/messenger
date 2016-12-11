class @ConversationsListRow extends React.Component
  render: ->
    `<a className="list-group-item list-group-item-action" href={this.props.conversation.messages_url}>
      <span className="right color-red">{this.props.conversation.new_messages_count}</span>
      {this.props.conversation.user_email}
    </a>`
