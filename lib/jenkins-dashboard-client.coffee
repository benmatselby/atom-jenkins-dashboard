http = require 'http'
https = require 'https'
urlParser = require 'url'

# Class responsible for interacting with Jenkins
class JenkinsDashboardClient
  # Instantiate the client with the url the Jenkins installation
  # sits on
  # @param url The URL for the Jenkins installation
  constructor: (@url) ->

  # Getter for the Jenkins Dashboard data from a given view
  # @param callback The callback that will render the dashboard in UI
  getDashboard: (callback) ->
    url = urlParser.parse(@url)
    protocol = if url.protocol.indexOf(":") is -1 then url.protocol else url.protocol.substring(0, url.protocol.indexOf(":"))
    protocol = if protocol is "http" then http else https

    self = this
    protocol.get @url + '/api/json', (reponse) ->
      self.parseGetJenkinsDashboard reponse, callback

  # Parse the Jenkins output
  # @param response The response from Jenkins
  # @param callback The callback that will render the dashboard in UI
  parseGetJenkinsDashboard: (response, callback) ->
    data = ''
    response.on 'data', (chunk) ->
      data += chunk.toString()
    response.on 'end', ->
      jobs = []
      try
        jenkinsData = JSON.parse data

        for job in jenkinsData.jobs
          jobs.push job

        callback jobs
      catch error
        console.error "[jenkins-dashboard] Error: #{error}"
        callback []


module.exports = JenkinsDashboardClient
