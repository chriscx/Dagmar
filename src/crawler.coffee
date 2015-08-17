{EventEmitter} = require 'events'
util = require 'util'
request = require 'request'
Queue = require './queue'
sleep = require 'sleep'


class Crawler extends EventEmitter
  constructor: (rateLimit = 10, maxRequests = 10) ->
    @_rateLimit = rateLimit
    @_maxRequests = maxRequests
    @_nbRequests = 0
    @_queue = new Queue()
    @_callback = (error, response, body) ->
      if !error and response.statusCode == 200
        console.log body
      else
        console.log error

    @on 'queue_next', ->
      sleep.usleep(@_rateLimit)
      url = @_queue.pop()
      @.crawl url, @_callback

    @on 'queue_empty', ->
      console.log 'Finish crawling. Queue is empty.'

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

  next: ->
    if @_queue.size == 0
      sleep.usleep(@_rateLimit)
      @emit 'queue_next'
      @emit 'queue_empty'

  crawl: (url, callback) ->
    ###
    Request url and manage results in callback
    ###
    request url, callback

  start: ->
    ###
    Will start crawling all urls in the queue
    ###
    while @_nbRequests < @_maxRequests and @_queue.size > 0
      @emit 'queue_next'
      @_nbRequests++


module.exports = Crawler
