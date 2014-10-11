class Request
  type: null
  time_handled: null
  time_created: null
  customer: null
  priority: null
  text: null
  resolved: 0
  elapsed: null

  resolved: ->
    @resolved = 1
    @request = null

  tick: (state) ->
    @elasped = state.tick - @time_created
    if(@elapsed % 15 == 0)
      @customer.lower_mood()


class PhoneRequest extends Request

class EmailRequest extends Request
