class Dialog
  # manipulates the $("#dialog").dialog box
  dialog = null

  setDialog: (@dialog) ->

  changeTitle: (newTitle) ->
    @dialog.dialog({title: newTitle})


  changeContent: (newContent) ->
    @dialog.html(newContent)

  changeButtons:(newButtons = null) ->
    @dialog.dialog("option", "buttons", newButtons)

  open: () ->
    @dialog.dialog( "open" )
  close: () ->
    @dialog.dialog("close")
