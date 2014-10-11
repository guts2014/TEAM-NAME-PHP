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
    document.body.appendChild table
    document.body.appendChild $("<div id='devConsole'></div>")[0]

  update: (state) ->
    console.log('should update the screen now', state)
    text = "Agents: " + state.agents.length + "<br />"
    text += "Customers: " + state.customers.length + "<br />"
    text += "Request queues: " + Object.keys(state.request_queues).length + "<br />"
    $("#devConsole").html(text)

  getTable: ->
    document.querySelector "#game"
  getCell: (x, y) ->
    table = this.getTable()
    table.getElementsByTagName("tr")[y].getElementsByTagName("td")[x]
