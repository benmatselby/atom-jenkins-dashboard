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

    if buildStatus is "blue"
      buildName += " [SUCCESS]"
    else if buildStatus is "blue_anmie"
      buildName += " [SUCCESS - BUILDING]"
    else if buildStatus is "yellow"
      buildName += " [UNSTABLE]"
    else if buildStatus is "yellow_anmie"
      buildName += " [UNSTABLE - BUILDING]"
    else if buildStatus is "red"
      buildName += " [FAILURE]"
    else if buildStatus is "red_anmie"
      buildName += " [FAILURE - BUILDING]"
    else if buildStatus is "aborted"
      buildName += " [ABORTED]"
    else if buildStatus is "aborted_anime"
      buildName += " [ABORTED - BUILDING]"
    else if buildStatus is "disabled"
      buildName += " [DISABLED]"
    else if buildStatus is "notbuilt"
      buildName += " [NO BUILDS]"
    else
      buildName += " [UNKNOWN]"

    $$ ->
      if buildName
        @li class: 'jenkins-dashboard two-lines', =>
          @div item, class: 'primary-line'
          @div buildName, class: 'secondary-line line-text'
      else
        @li class: 'jenkins-dashboard', =>
          @div item, class: 'primary-line'

  # Confirmed location
  # @param item The item that has been selected by the user
  confirmed: (item) ->
    # Need to do a little more in the future
    console.log item.name + ' selected'

module.exports = JenkinsDashboardView
