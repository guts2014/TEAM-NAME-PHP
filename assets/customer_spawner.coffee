class CustomerSpawner
  potential_customers: [] # Holds all potential customers from customers.json

  constructor: ->
    $.ajax("assets/data/customers.json").done($.proxy((kana_customers) ->
        for kana_customer in kana_customers
          customer = new Customer
          customer.fromKanaCustomer kana_customer
          @potential_customers.push(customer)
      , this)
    )

  calculateMaximumCustomers: (reputation) ->
    200 * Math.pow(reputation, 1.5)

  tick: (state) ->
    reputation = state.reputation
    if @potential_customers.length > 0 and Math.random() < reputation and this.calculateMaximumCustomers(reputation) > state.customers.length
      customer = @potential_customers.pop()
      state.customers.push(customer)
      state.tickables.push(customer)
      if @potential_customers.length == 0
        this.constructor()
