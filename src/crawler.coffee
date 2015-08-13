EventEmitter = require('events').EventEmitter
util = require 'util'
request = require 'request'
Queue = require './queue'

class Crawler
  constructor: ->
    EventEmitter.call this
    util.inherits this, EventEmitter
    @_queue = new Queue()
    @_callback = (error, response, body) ->
      if !error and response.statusCode == 200
        console.log body
      else
        console.log error

  do: (callback) ->
    ###
    Callback to be executed when url has been requested
    ###
    @_callback = callback
    return callback

  queue: (url) ->
    ###
    Push an url in the queue to be crawled
    ###
    @_queue.push(url)
    return url

  crawl: (url, callback) ->
    ###
    Request url and manage results in callback
    ###
    request url, callback

  start: ->
    ###

    ###
    while @_queue.size > 0
      url = @_queue.pop()
      @.crawl url, @_callback


module.exports = Crawler
