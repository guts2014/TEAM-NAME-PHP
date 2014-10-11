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

  calculateMaximumCustomers: ->
    10 # TODO actual logic here based on reputation?

  tick: (state) ->
    if Math.random() < 0.1 and this.calculateMaximumCustomers() > state.customers.length
      customer = $.extend({}, @potential_customers[Math.floor(Math.random() * @potential_customers.length)])
      state.customers.push(customer)
