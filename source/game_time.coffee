class GameTime
  days: 0
  hours: 0
  minutes: 0

  constructor: (tick) ->
    this.setTime(tick)

  setTime: (tick) ->
    @minutes = tick % 60
    @hours   = Math.floor((tick / 60) % 24)
    @days    = Math.floor(tick / (60 * 24))


  toString: ->
    pad = (n) ->
      if n < 10
        return '0'+n
      else
        return n
    return "Day " + @days + " - " + pad(@hours) + ":" + pad(@minutes)
