JenkinsDashboardClient = require './jenkins-dashboard-client'

# Main controller class
class JenkinsDashboard
  # Instantiate the views and register commands etc
  constructor: (dashboardView) ->
    @dashboardView = dashboardView
    atom.workspaceView.command "jenkins-dashboard:show-dashboard", => @showDashboard()

  # Show the dashboard in the list view
  # Show each jenksin job
  showDashboard: ->
    url = atom.config.get("jenkins-dashboard.jenkinsUrl")
    jenkins = new JenkinsDashboardClient(url)
    self = this
    jenkins.getDashboard (jobs) =>
      @dashboardView.display jobs

module.exports = JenkinsDashboard
