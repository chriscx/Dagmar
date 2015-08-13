should = require 'should'
Crawler = require '../src/crawler'
Queue = require '../src/queue'

describe 'Crawler', ->
  describe 'init', ->
    it 'should initialize a crawler object', ->
      crawler = new Crawler()
      crawler._queue.should.be.instanceof(Queue)

  describe 'crawl', ->
    it 'should return -1 when the value is not present', ->
      crawler = new Crawler()
      crawler.crawl("http://www.google.com"
        ,(res, body) ->
          res.should.equal(200)
        ,(res, error) ->
          res.should.not.equal(200)
      )

  describe 'start', ->
    it 'should return -1 when the value is not present', ->
      crawler = new Crawler()
      crawler.onSuccess((res, body) ->
        res.should.equal(200)
      )
      crawler.onFailure((res, error) ->
        res.should.not.equal(200)
      )
      crawler.queue("http://www.google.com")
      crawler.queue("http://www.yahoo.com")
      crawler.start
