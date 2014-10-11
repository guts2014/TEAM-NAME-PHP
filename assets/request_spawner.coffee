class RequestSpawner
  tick: (state) ->
    if 5 < Math.random()*10
      console.log('should spawn request')
      state.request_queues[0].requests.push('TEST')
