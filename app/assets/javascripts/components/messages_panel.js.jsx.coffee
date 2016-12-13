@MessagesPanel = React.createClass
  getInitialState: ->
    messages: @props.messages || []
    loadMorePath: @props.loadMorePath
    loadNewPath: @props.loadNewPath
    createMessagePath: @props.createMessagePath
    loading: false
    historyLoading: false

  componentDidMount: ->
    @scheduleUpdate()

  getLoadHistoryLink: ->
    if @state.loadMorePath?
      `<div className="btn-group">
        <button className="btn btn-default" disabled={this.state.historyLoading} onClick={this.handleLoadMoreClick}>load more</button>
      </div>`

  getLoadNewMessagesLink: ->
    `<div className="btn-group">
      <button className="btn btn-default" disabled={this.state.loading} onClick={this.handleLoadNewMessagesClick}>refresh</button>
    </div>`

  getNewMessageForm: ->
    if @state.createMessagePath?
      `<MessageForm path={this.state.createMessagePath} onNewMessage={this.onNewMessage}/>`

  handleLoadMoreClick: ->
    @setState(loading: true)
    $.get @state.loadMorePath, (data) =>
      @setState
        messages: @state.messages.concat data.messages
        loadMorePath: data.loadMorePath
        loading: false

  handleLoadNewMessagesClick: ->
    @loadNewMessages()

  loadNewMessages: ->
    @setState(loading: true)
    $.get @state.loadNewPath, @onNewMessage

  scheduleUpdate: ->
    clearTimeout @timeout if @timeout?
    @timeout = setTimeout @loadNewMessages, 5000

  onNewMessage: (data) ->
    @scheduleUpdate()
    if data.messages?
      @setState
        messages: data.messages.concat @state.messages
        loadNewPath: data.loadNewPath
        createMessagePath: data.createMessagePath
        loading: false
    else
      @setState loading: false

  render: ->
    console.debug(this.state.messages)
    `<div>
      {this.getNewMessageForm()}
      {this.getLoadNewMessagesLink()}
      <MessagesList messages={this.state.messages} recent={this.props.recent}/>
      {this.getLoadHistoryLink()}
    </div>`
