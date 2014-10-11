class GameTime
  days: 0
  hours: 0
  minutes: 0
  
  constructor: (tick) ->
    this.setTime(tick)

  setTime: (tick) ->
    @minutes = tick % 60
    @hours = Math.floor(tick / 60)
    @days = Math.floor(tick / (60 * 24))


  toString: ->
    return "Days: " + @days + " Hours: " + @hours + " Minutes: " + @minutes
