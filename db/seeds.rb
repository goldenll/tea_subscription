# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

@customer1 = Customer.create!(first_name: "Simon", last_name: "Golden", email: "simon@gmail.com", address: "123 Main St")
@customer2 = Customer.create!(first_name: "Dolly", last_name: "Parton", email: "dollyp@gmail.com", address: "456 Main St")

@subscription1 = Subscription.create!(title: "Green Tea", price: 10.00, frequency: "monthly")
@subscription2 = Subscription.create!(title: "Earl Grey Tea", price: 15.00, frequency: "weekly")
@subscription3 = Subscription.create!(title: "Black Tea", price: 20.00, frequency: "biweekly")

@customer_subscription1 = CustomerSubscription.create!(customer_id: @customer1.id, subscription_id: @subscription1.id, status: 1)
@customer_subscription2 = CustomerSubscription.create!(customer_id: @customer1.id, subscription_id: @subscription2.id, status: 1)
@customer_subscription3 = CustomerSubscription.create!(customer_id: @customer1.id, subscription_id: @subscription3.id, status: 0)
@customer_subscription4 = CustomerSubscription.create!(customer_id: @customer2.id, subscription_id: @subscription1.id, status: 0)
@customer_subscription5 = CustomerSubscription.create!(customer_id: @customer2.id, subscription_id: @subscription2.id, status: 1)
