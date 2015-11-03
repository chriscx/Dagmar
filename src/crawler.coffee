{EventEmitter} = require 'events'
util = require 'util'
request = require 'request'
Queue = require './queue'
sleep = require 'sleep'
http = require('http')

class Crawler
  constructor: (rateLimit = 10, maxRequests = 10) ->
    @_rateLimit = rateLimit
    @_maxRequests = maxRequests
    @_nbRequests = 0
    @_queue = new Queue()
    @_event = new EventEmitter()
    @_forEachCallback = (error, response, body) ->
      if !error and response.statusCode == 200
        console.log body
      else
        console.log error
    @_endCallback = ->
      console.log 'end.'

  forEach: (callback) ->
    ###
    Callback to be executed when url has been requested
    ###
    @_forEachCallback = callback
    return @

  end: (callback) ->
    ###
    Callback to be executed when queue is empty
    ###
    @_endCallback = callback
    return @

  queue: (url) ->
    ###
    Push an url in the queue to be crawled
    ###
    @_queue.push(url)
    return @

  crawl: (url) ->
    ###
    Request url and manage results in callback specified by do function
    ###
    request url, @_forEachCallback

  start: ->
    ###
    Will start crawling all urls in the queue
    ###

    event = new EventEmitter()

    req = (url, callback) ->
      console.log "Fake http request to #{url}"
      response =
        statusCode: 200
      setTimeout () ->
        callback(null, response, 'fake body')
      , 1000

    event.on 'crawl_next', (self) ->
      url = self._queue.pop()
      if url?
        console.log url
        sleep.usleep self._rateLimit
        request url, (error, response, body) ->
          self._nbRequests--
          sleep.usleep self._rateLimit
          self._forEachCallback error, response, body
          if self._queue.size > 0
            process.nextTick ->
              event.emit 'crawl_next', self
          else
              event.emit 'crawl_end'
        self._nbRequests++

    event.once 'crawl_end', @_endCallback

    while @_nbRequests < @_maxRequests and @_queue.size > 0
      event.emit 'crawl_next', this
    return @


module.exports = Crawler
