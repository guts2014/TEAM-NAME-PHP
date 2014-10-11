class GameRenderer
  getTable: ->
    document.querySelector "#game"
  getCell: (x, y) ->
    table = this.getTable()
    table.getElementsByTagName("tr")[y].getElementsByTagName("td")[x]
