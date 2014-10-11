class TableGameRenderer
  setup: (width, height) ->
    table = document.createElement 'table'
    table.id = 'game'

    for x in [0..height-1]
      row = document.createElement 'tr'
      for y in [0..width-1]
        cell = document.createElement 'td'
        row.appendChild cell
      table.appendChild row
    document.body.appendChild table
    document.body.appendChild $("<div id='devConsole'></div>")[0]

  render: (state) ->
    console.log('Update screen now', state)

    this.resetTable()

    for desk in state.level.desks
      cell = this.getCell(desk[0], desk[1])
      $(cell).addClass('desk');



    text  = "Agents: " + state.agents.length + "<br />"
    text += "Customers: " + state.customers.length + "<br />"
    text += "Request queues: " + Object.keys(state.request_queues).length + "<br />"
    $("#devConsole").html(text)


  resetTable: ->
    $('#game td').removeClass('desk')


  getTable: ->
    document.querySelector "#game"
  getCell: (x, y) ->
    table = this.getTable()
    table.getElementsByTagName("tr")[y].getElementsByTagName("td")[x]
