class Desk extends Renderable
  modelName: -> 'small_desk'

  onClick: () ->
    console.log('Somebody clicked me!')
