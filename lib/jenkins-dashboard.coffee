JenkinsDashboardView = require './jenkins-dashboard-view'

module.exports =

  configDefaults:
    jenkinsUrl: 'https://ci.jenkins-ci.org/view/All/'

  jenkinsDashboardView: null

  activate: (state) ->
    @jenkinsDashboardView = new JenkinsDashboardView(state.jenkinsDashboardViewState)

  deactivate: ->
    @jenkinsDashboardView.destroy()

  serialize: ->
    jenkinsDashboardViewState: @jenkinsDashboardView.serialize()
