http = require 'http'
https = require 'https'
urlParser = require 'url'
JenkinsDashboardClient = require '../lib/jenkins-dashboard-client'

describe "JenkinsDashboardClient", ->
  it 'should call http if the Jenkins url is http based', ->
    client = new JenkinsDashboardClient('http://somewhere.com')
    spyOn(http, 'get')
    client.getDashboard (jobs) ->
      console.log '1'
    expect(http.get).toHaveBeenCalled()

  it 'should call https if the Jenkins url is https based', ->
    client = new JenkinsDashboardClient('https://somewhere.com')
    spyOn(https, 'get')
    client.getDashboard (jobs) ->

    expect(https.get).toHaveBeenCalled()
