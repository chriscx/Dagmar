should = require 'should'
Queue = require '../src/queue'

describe 'Queue', ->
  describe 'init', ->
    it 'should initialize a queue object with values', ->
      q = new Queue([1, 2, 3])
      q._values.should.be.instanceof(Array).and.eql([1, 2, 3])
  describe 'push', ->
    it 'should push an element in the queue', ->
      q = new Queue()
      q.push(1)
      q._values.should.be.instanceof(Array).and.eql([1])

  describe 'pop', ->
    it 'should pop an element out of the queue', ->
    q = new Queue([1, 2, 3])
    v = q.pop()
    v.should.equal(1)
    q._index.should.equal(1)

  describe 'peek', ->
    it 'should return next element without removing it', ->
    q = new Queue([1, 2, 3])
    q.peek().should.equal(1)
