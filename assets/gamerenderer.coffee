class GameRenderer
  setup: (width, height) ->
    #document.querySelector('body').append


  getTable: ->
    document.querySelector "#game"
  getCell: (x, y) ->
    table = this.getTable()
    table.getElementsByTagName("tr")[y].getElementsByTagName("td")[x]
