{$$, Point, SelectListView} = require 'atom'
JenkinsDashboardClient = require './jenkins-dashboard-client'

# Jenkins view
class JenkinsDashboardView extends SelectListView

  # Initialise the view and register the Jenkins commands
  initialize: (serializeState) ->
    atom.workspaceView.command "jenkins-dashboard:show-dashboard", => @showDashboard()
    super
    @addClass('jenkins-dashboard-view overlay from-top')

  # Show the dashboard in the list view
  # Show each jenksin job
  showDashboard: ->
    url = atom.config.get("jenkins-dashboard.jenkinsUrl")
    jenkins = new JenkinsDashboardClient(url)
    self = this
    jenkins.getDashboard (jobs) ->
      self.display jobs

  # Display the jobs in the list view
  # @param jobs The list of jobs from the Jenkins view
  display: (jobs) ->
    @setItems(jobs)
    @storeFocusedElement()
    atom.workspaceView.append(this)
    @focusFilterEditor()

  # Renderer for each item in the select list
  # @param item The item in the list view
  viewForItem: (item) ->
    buildName = item.name
    buildStatus = item.color

    switch buildStatus
      when "blue", "blue_anime" then status = 'green'
      when "yellow", "yellow_anime" then status = 'yellow'
      when "red", "red_anime" then status = 'red'
      else status = 'aborted'

    $$ ->
      if buildName
        @li class: 'jenkins-dashboard jenkins-' + status, =>
          @div item, class: 'primary-line'
          @div buildName, class: 'secondary-line line-text'
      else
        @li class: 'jenkins-dashboard jenkins-' + status, =>
          @div item, class: 'primary-line'

  # Confirmed location
  # @param item The item that has been selected by the user
  confirmed: (item) ->
    # Need to do a little more in the future
    console.log item.name + ' selected'

module.exports = JenkinsDashboardView
