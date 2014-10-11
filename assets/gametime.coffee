class GameTime
  days: null
  hours: null
  minutes: null

  ticksperminute: 1

  tick: (state) ->

    @remainderD = state.tick % (@ticksperminute * 60 * 24)
    @days = state.tick / (@ticksperminute * 60 * 24) - @remainder
    @remainderH = @remainderD % (@ticksperminute * 60)
    @hours = @remainderD / (@ticksperminute * 60)
    @minutes = @remainderH / @ticksperminute
