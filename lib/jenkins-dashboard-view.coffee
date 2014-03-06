{$$, Point, SelectListView} = require 'atom'

# Jenkins view
class JenkinsDashboardView extends SelectListView

  # Initialise the view and register the Jenkins commands
  initialize: () ->
    super
    @addClass('jenkins-dashboard-view overlay from-top')

  # Getter for the property name to filter the list on
  getFilterKey: ->
    'name'

  # Display the jobs in the list view
  #
  # jobs The list of jobs from the Jenkins view
  display: (jobs) ->
    @setItems(jobs)
    @storeFocusedElement()
    atom.workspaceView.append(this)
    @focusFilterEditor()

  # Renderer for each item in the select list
  #
  # item The item in the list view
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
  #
  # item The item that has been selected by the user
  confirmed: (item) ->
    # Need to do a little more in the future
    console.log item.name + ' selected'

module.exports = JenkinsDashboardView
