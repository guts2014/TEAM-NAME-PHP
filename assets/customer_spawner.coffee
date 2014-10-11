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

  tick: (state) ->

