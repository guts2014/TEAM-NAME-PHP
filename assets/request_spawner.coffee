class RequestSpawner
  tick: (state) ->
    if 5 < Math.random()*10
      this.spawnRequest(state)

  spawnRequest: (state) ->
    request_queues = state.requestQueues
    keys = Object.keys(request_queues)
    request_queues[keys[ keys.length * Math.random() << 0]].requests.push(new EmailRequest)
