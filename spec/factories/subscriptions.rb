FactoryBot.define do
  factory :subscription do
    title { Faker::Tea.variety }
    price { Faker::Number.decimal(l_digits: 2) }
    frequency { Faker::Subscription.subscription_term }
  end
end
