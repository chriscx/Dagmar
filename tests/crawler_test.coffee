should = require 'should'
Crawler = require '../src/crawler'
Queue = require '../src/queue'


describe 'Crawler', ->
  describe 'init', ->
    it 'should initialize a crawler object', (done) ->
      crawler = new Crawler()
      crawler._queue.should.be.instanceof(Queue)
      done()

  describe 'crawl', ->
    it 'should crawl url', (done) ->
      crawler = new Crawler()
      crawler.forEach (error, response, body) ->
        response.statusCode.should.equal(200)
        done()

      crawler.crawl 'http://www.google.com'

  describe 'start', ->
    it 'should crawl all urls in queue', (done) ->
      crawler = new Crawler(1000, 10)
      crawler.forEach (error, response, body) ->
        response.statusCode.should.equal(200)
      crawler.end ->
        done()

      crawler.queue("http://www.google.com")
      crawler.queue("http://www.yahoo.com")
      crawler.queue("http://www.apple.com")
      crawler.queue("http://www.twitter.com")
      crawler.queue("http://www.facebook.com")
      crawler.start()
