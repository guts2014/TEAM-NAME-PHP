class SmallDesk extends Entity
  modelName: -> 'small_desk'

  onClick: () ->
    console.log('Somebody clicked me!')


class LargeDesk extends SmallDesk
  modelName: -> 'large_desk'
