@Program = React.createClass
  fetchPrograms: ->
    $.ajax
      url: '/programs.json'
      success: (res) =>
        @setState(programs: res)
  fetchWatchings: ->
    $.ajax
      url: '/programs/watching.json'
      success: (res) =>
        @setState(login: true, watchings: res, filter: 'my-programs')
      failure: (res) =>
        @setState(login: false, watchings: null, filter: 'all-programs')
  filters:
    'my-programs': 'watchings'
    'my-channels': 'watchables'
    'all-programs': 'all-programs'
  componentDidMount: ->
    $(document).on 'switchChange.bootstrapSwitch', '.triggerWatch', @triggerWatch
    @fetchPrograms()
    @fetchWatchings()
  componentDidUpdate: ->
    $('.triggerWatch').bootstrapSwitch()
  getInitialState: ->
    programs: [], filter: 'all-programs', login: false
  changeFilter: (evt) ->
    @setState(filter: $(evt.target).data('filter'))
  triggerWatch: (evt, state) ->
    target = $(evt.target)
    id = target.data('id')
    method = if state then 'PUT' else 'DELETE'
    $.ajax
      url: "/titles/#{id}.json"
      method: method
      success: =>
        @fetchPrograms()
  render: ->
    programs = for program in @state.programs
      `<Program.Row key={program.id} program={program} filter={this.state.filter} login={this.state.login} />`
    triggers = `<Program.Trigger handler={this.changeFilter} filter={this.state.filter} filters={this.filters} />` if @state.login
    header = `<th>{ I18n.t('domain.watchings') }</th>` if @state.login
    `<div>
      <div className="clearfix">
        <h1 className="pull-left">{ I18n.t('view.programs.title') }</h1>
        {triggers}
      </div>
      <table className="table table-hover">
        <thead>
          <tr>
            <th>{ I18n.t('models.program.start') }</th>
            <th>{ I18n.t('models.program.channel') }</th>
            <th>{ I18n.t('models.program.title') }</th>
            <th>{ I18n.t('models.program.subtitle') }</th>
            {header}
          </tr>
        </thead>
        <tbody id="programs" className={this.state.filter}>{programs}</tbody>
      </table>
    </div>`

@Program.Trigger = React.createClass
  render: ->
    buttons = for filter, key of @props.filters
      classes = ['btn', 'btn-default']
      classes.push 'active' if @props.filter == filter
      label = I18n.t("domain.#{key}")
      `<a className={classes.join(' ')} key={filter} onClick={this.props.handler} data-filter={filter}>{label}</a>`
    `<div className="pull-right btn-group">{buttons}</div>`

@Program.Row = React.createClass
  timeExpression: (ms) ->
    date = new Date(ms * 1000)
    hours = date.getHours()
    hours + 24 if date.getHours() < 5
    window.sprintf("%02d:%02d", hours, date.getMinutes())
  render: ->
    classes = []
    classes.push 'watching' if @props.program.watch
    classes.push 'watchable' if @props.program.channel.watch
    switch @props.filter
      when 'my-channels'
        classes.push 'info' if @props.program.watch
      when 'all-programs'
        if @props.program.channel.watch
          if @props.program.watch
            classes.push 'success'
          else
            classes.push 'warning'
        else if @props.program.watch
          classes.push 'info'

    button = `<td>
      <input type="checkbox"
        ref="watch"
        className="triggerWatch"
        data-id={this.props.program.title.id}
        defaultChecked={this.props.program.watch} />
    </td>` if @props.login

    `<tr className={classes.join(' ')}>
      <td>{ this.timeExpression(this.props.program.start_at) }</td>
      <td>{ this.props.program.channel.name }</td>
      <td>{ this.props.program.title.name }</td>
      <td>#{ this.props.program.story.number } { this.props.program.story.subtitle }</td>
      {button}
    </tr>`
