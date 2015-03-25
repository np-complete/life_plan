@Title = React.createClass
  loadJson: (callback = null)->
    $.ajax
      url: '/titles.json'
      data: @state.options
      success: (res) =>
        @setState(res)
        callback() if callback
  pushHistoryState: ->
    if window.history && window.history.pushState
      url = window.location.pathname + '?' + jQuery.param(page: @state.options.page)
      window.history.pushState(@state, null, url)
  replaceHistoryState: ->
    if window.history && window.history.replaceState
      window.history.replaceState(@state)
  popState: (evt) ->
    @setState(evt.originalEvent.state)
  componentDidMount: ->
    $(window).on 'popstate', @popState
    @loadJson(@replaceHistoryState)

  getInitialState: ->
    {titles: [], options: @props.options, pages: 0}
  handlePageChange: (page) ->
    options = @state.options
    options.page = page
    @setState(options: options)
    @loadJson(@pushHistoryState)
  render: ->
    paginator = `<Title.Paginator pages={this.state.pages} page={this.state.options.page}  onPageChange={this.handlePageChange} />` if @state.pages > 0
    titles = this.state.titles.map (title) ->
      `<Title.Row key={title.id} id={title.id} name={title.name} watch={title.watch} />`
    `<div>
      {paginator}
      <table className="table table-striped">
        <thead>
          <tr>
            <th>{ I18n.t('models.program.title') }</th>
            <th>{ I18n.t('domain.watchings') }</th>
          </tr>
        </thead>
        <tbody>{titles}</tbody>
      </table>
      {paginator}
    </div>`

@Title.Paginator = React.createClass
  propTypes:
    pages: React.PropTypes.number
    page: React.PropTypes.number
  handlePaginate: (evt) ->
    evt.stopPropagation()
    evt.preventDefault()
    page = Number(evt.target.getAttribute('data-page'))
    @props.onPageChange(page) if page >= 1 && page <= @props.pages
  render: ->
    first_page = Math.max(@props.page - 4, 1)
    last_page = Math.min(first_page + 8, @props.pages)
    first_page = Math.max(1, last_page - 8)
    first = @props.page == 1
    last  = @props.page == @props.pages

    pages = for num in [first_page..last_page]
      if num == @props.page
        `<li className="active"><a href="#" onClick={this.handlePaginate} data-page={num}>{num}</a></li>`
      else
        `<li><a href="#" onClick={this.handlePaginate} data-page={num}>{num}</a></li>`

    `<div className="centered">
      <ul className="pagination">
        <li className={ first ? 'disabled' : '' }>
          <a href="#" onClick={this.handlePaginate} data-page="1">« First</a>
        </li>
        <li className={ first ? 'disabled' : '' }>
          <a href="#" onClick={this.handlePaginate} data-page={this.props.page - 1}>‹ Prev</a>
        </li>
        {pages}
        <li className={ last ? 'disabled' : '' }>
          <a href="#" onClick={this.handlePaginate} data-page={this.props.page + 1}>Next ›</a>
        </li>
        <li className={ last ? 'disabled' : '' }>
          <a href="#" onClick={this.handlePaginate} data-page={this.props.pages}>Last »</a>
        </li>
      </ul>
    </div>`

@Title.Row = React.createClass
  propTypes:
    id: React.PropTypes.number
    name: React.PropTypes.string
    watch: React.PropTypes.bool
  switcher: ->
    $(this.refs.watch.getDOMNode())

  getInitialState: ->
    watch: @props.watch
  handleChange: (e, state) ->
    method = if state then "PUT" else "DELETE"
    $.ajax {
      url: "/titles/#{@props.id}",
      method: method
      success: ((res) =>
        @setState(watch: state)).bind(@)
      error: ((res) =>
        @switcher().bootstrapSwitch('state', !state)).bind(@)
    }
  componentDidMount: ->
    @switcher().bootstrapSwitch()
    @switcher().on 'switchChange.bootstrapSwitch', this.handleChange

  render: ->
    `<tr>
      <td>{this.props.name}</td>
      <td>
        <input type="checkbox"
          ref="watch"
          defaultChecked={this.state.watch} />
      </td>
    </tr>`
