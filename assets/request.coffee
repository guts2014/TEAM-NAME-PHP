class Request
  type: null
  time_handled: null
  customer: null
  priority: null
  text: null
  resolved: 0


  resolved: ->
    @resolved = 1
    @request = null


class PhoneRequest extends Request

class EmailRequest extends Request
