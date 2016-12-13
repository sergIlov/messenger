@Message = React.createClass
  getInitialState: ->
    sender: @props.message.sender
    createdAt: @props.message.createdAt
    text: @props.message.text
    reply: @props.reply
    isRead: @props.message.isRead
    type: @props.message.type
    markReadPath: @props.message.markReadPath
    replyPath: @props.message.replyPath
    loading: false

  getReplyLink: ->
    if @state.reply
      `<a href={this.state.replyPath}>Reply</a>`
    else
      ''

  getClassName: ->
    "list-group-item #{@getAdditionalClassName()}"

  getAdditionalClassName: ->
    if !@state.isRead
      if @state.type == 'incoming'
        'list-group-item-info'
      else
        'list-group-item-warning'
    else
      ''

  handleMouseOver: (event) ->
    if @shouldBeMarkedAsRead()
      @setState loading: true
      $.post @state.markReadPath, {}, =>
        @setState isRead: true

  shouldBeMarkedAsRead: ->
    @state.type == 'incoming' && !@state.isRead && !@state.loading

  render: ->
    `<div className={this.getClassName()} onMouseOver={this.handleMouseOver}>
      <h6 className="list-group-heading">
        {this.state.sender}
        <span className="right">{this.state.createdAt}</span>
      </h6>
      <p className="list-group-item-text">{this.state.text}</p>
      {this.getReplyLink()}
    </div>`