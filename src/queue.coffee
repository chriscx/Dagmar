class Queue
  constructor: (initialArray = []) ->
    ###
    Pass an optional array to be transformed into a queue. The item at index 0
    is the first to be dequeued.
    ###
    @_values = initialArray
    @_index = 0
    @size = @_values.length

  push: (item) ->
    ###
    _Returns:_ the item.
    ###
    @size++
    @_values.push(item)
    return item

  pop: ->
    ###
    _Returns:_ the dequeued item.
    ###
    if @size is 0 then return
    @size--
    itemToDequeue = @_values[@_index]
    @_index++
    if @_index * 2 > @_values.length
      @_values = @_values.slice(@_index)
      @_index = 0
    return itemToDequeue

  peek: ->
    ###
    Check the next item to be dequeued, without removing it.
    _Returns:_ the item.
    ###
    @_values[@_index]


module.exports = Queue
