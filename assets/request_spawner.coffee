class RequestSpawner
  tick: (state) ->
    if 5 < Math.random()*10
      this.spawnRequest(state)

  spawnRequest: (state) ->
    state.request_queues['email'].requests.push(new EmailRequest)
