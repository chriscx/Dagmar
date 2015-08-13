EventEmitter = require('events').EventEmitter
util = require 'util'
request = require 'request'
Queue = require './queue'

Crawler = ->
  ###

  ###
  @_queue = new Queue()
  @_onSuccess = (body) ->
    console.log body
  @_onFailure = (error) ->
    console.log error
  EventEmitter.call this
  return this

util.inherits Crawler, EventEmitter

Crawler::onSuccess = (callback) ->
  ###

  ###
  @_onSuccess = callback

Crawler::onFailure = (callback) ->
  ###

  ###
  @_onFailure = callback

Crawler::queue = (url) ->
  ###

  ###
  @_queue.push(url)

Crawler::crawl = (url, onSuccess, onFailure) ->
  ###

  ###
  request url, (error, response, body) ->
    if !error and response.statusCode == 200
      onSuccess(response, body)
    else
      onFailure(response, error)

Crawler::start = ->
  ###

  ###
  while @_queue.size > 0
    this.crawl @_queue.pop, @_onSuccess, @_onFailure


module.exports = Crawler
