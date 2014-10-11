class RequestLoader

  constructor: (state) ->
    $.ajax("/assets/data/requests.json").done(state.requestQueues)
