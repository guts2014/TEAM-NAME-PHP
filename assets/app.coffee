gamestate = {}

getGameTable = ->
  document.querySelector "#game"
getCell = (x, y) ->
  table = getGameTable()
  table.getElementsByTagName("tr")[y].getElementsByTagName("td")[x]

getCell(3, 2).style.background = "green"
