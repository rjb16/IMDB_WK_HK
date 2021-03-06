require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pry-byebug')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()


customer1 = Customer.new({
    'name' => 'John',
    'funds' => 20
})

customer1.save()

film1 = Film.new({
    'title' => 'Die Hard',
    'price' => 15
})

film1.save()

ticket1 = Ticket.new({
    'customer_id' => customer1.id,
    'film_id' => film1.id
})

ticket1.save()


binding.pry
nil