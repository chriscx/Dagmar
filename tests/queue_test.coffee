should = require 'should'
Queue = require '../src/queue'

describe 'Queue', ->
  describe 'init', ->
    it 'should initialize a queue object with values', (done) ->
      q = new Queue([1, 2, 3])
      q._values.should.be.instanceof(Array).and.eql([1, 2, 3])
      done()

  describe 'push', ->
    it 'should push an element in the queue', (done) ->
      q = new Queue()
      q.push(1)
      q._values.should.be.instanceof(Array).and.eql([1])
      done()

  describe 'pop', ->
    it 'should pop an element out of the queue', (done) ->
      q = new Queue([1, 2, 3])
      v = q.pop()
      v.should.equal(1)
      q._index.should.equal(1)
      done()

  describe 'peek', ->
    it 'should return next element without removing it', (done) ->
      q = new Queue([1, 2, 3])
      q.peek().should.equal(1)
      done()
