JenkinsDashboard = require './jenkins-dashboard'
JenkinsDashboardView = require './jenkins-dashboard-view'

module.exports =

  configDefaults:
    jenkinsUrl: 'https://ci.jenkins-ci.org/view/All/'

  # Activate the plugin
  activate: ->
    dashboardView = new JenkinsDashboardView()
    app = new JenkinsDashboard dashboardView
