class CustomerSpawner
  potential_customers: [] # Holds all potential customers from customers.json

  constructor: ->
    $.ajax("/assets/data/customers.json").done($.proxy((kana_customers) ->
        for kana_customer in kana_customers
          customer = new Customer
          customer.from_kana_customer kana_customer
          @potential_customers.push(customer)
      , this)
    )

  calculateMaximumCustomers: (reputation) ->
    200 * Math.pow(reputation, 1.5)

  tick: (state) ->
    reputation = state.reputation
    if @potential_customers.length > 0 and Math.random() < reputation and this.calculateMaximumCustomers(reputation) > state.customers.length
      customer = $.extend({}, @potential_customers[Math.floor(Math.random() * @potential_customers.length)])
      state.customers.push(customer)
      state.tickables.push(customer)
