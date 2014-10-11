class GameRenderer
  setup: (width, height) ->
    table = document.createElement 'table'
    table.id = 'game'

    for x in [1..height]
      row = document.createElement 'tr'
      for y in [1..width]
        cell = document.createElement 'td'
        row.appendChild cell
      table.appendChild row
    document.querySelector('body').appendChild table


  update: (state) ->
    console.log('should update the screen now', state)

  getTable: ->
    document.querySelector "#game"
  getCell: (x, y) ->
    table = this.getTable()
    table.getElementsByTagName("tr")[y].getElementsByTagName("td")[x]
