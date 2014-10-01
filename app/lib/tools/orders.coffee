TextWidget = require './text-widget'
labels = require '../notes'

class OrdersWidget extends TextWidget
  template: require( '../../views/tools/orders' )( types: labels.orders )
  
  type: 'orders'
  help: '/orders/orders'
  
  getLabel: (target) ->
    $(target).find(':selected').text()

module.exports = OrdersWidget