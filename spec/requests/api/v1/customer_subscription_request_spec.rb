require 'rails_helper'

describe "Customer Subscription API" do
  it "a customer can subscribe to a tea subscription" do
    subscription1 = create(:subscription)
    customer1 = create(:customer)

    expect(customer1.customer_subscriptions.count).to eq(0)

    post "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}"

    expect(response).to be_successful
    expect(customer1.customer_subscriptions.count).to eq(1)

    cs = JSON.parse(response.body, symbolize_names: true)

    expect(cs).to be_a(Hash)
    expect(cs).to have_key(:customer)
    expect(cs[:customer]).to be_a(Hash)
    expect(cs[:customer]).to have_key(:id)
    expect(cs[:customer]).to have_key(:first_name)
    expect(cs[:customer]).to have_key(:last_name)
    expect(cs[:customer]).to have_key(:email)
    expect(cs[:customer]).to have_key(:address)

    expect(cs).to have_key(:subscription)
    expect(cs[:subscription]).to be_a(Hash)
    expect(cs[:subscription]).to have_key(:id)
    expect(cs[:subscription]).to have_key(:title)
    expect(cs[:subscription]).to have_key(:price)
    expect(cs[:subscription]).to have_key(:frequency)
  end

  it "a customer can delete a tea subscription" do
    subscription1 = create(:subscription)
    subscription2 = create(:subscription)
    subscription3 = create(:subscription)
    customer1 = create(:customer)
    customer2 = create(:customer)

    post "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}"
    post "/api/v1/customers/#{customer2.id}/subscriptions/#{subscription1.id}"
    post "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription2.id}"
    post "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription3.id}"

    expect(customer1.customer_subscriptions.count).to eq(3)

    delete "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}"

    expect(response).to be_successful
    done = JSON.parse(response.body, symbolize_names: true)

    expect(customer1.customer_subscriptions.count).to eq(2)

    expect(done).to be_a(Hash)
    expect(done).to have_key(:message)
    expect(done[:message]).to be_a(String)
    expect(done[:message]).to eq("Subscription successfully canceled")
  end
  # not what we want, we want to return a customers subscription history rather than delete a subscription oops

  it "a customer can cancel a tea subscription" do
    subscription1 = create(:subscription)
    subscription2 = create(:subscription)
    subscription3 = create(:subscription)
    customer1 = create(:customer)
    customer2 = create(:customer)

    post "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}"
    post "/api/v1/customers/#{customer2.id}/subscriptions/#{subscription1.id}"
    post "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription2.id}"
    post "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription3.id}"

    expect(customer1.customer_subscriptions[0].status).to eq("active")
    
    patch "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}"
    
    expect(response).to be_successful
    done = JSON.parse(response.body, symbolize_names: true)

    expect(CustomerSubscription.all.first.status).to eq("canceled")
    expect(done).to be_a(Hash)
    expect(done).to have_key(:message)
    expect(done[:message]).to be_a(String)
    expect(done[:message]).to eq("Subscription successfully canceled")
  end

  it "returns a customers subscription history" do
    subscription1 = create(:subscription)
    subscription2 = create(:subscription)
    subscription3 = create(:subscription)
    customer1 = create(:customer)
    customer2 = create(:customer)

    post "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}"
    post "/api/v1/customers/#{customer2.id}/subscriptions/#{subscription1.id}"
    post "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription2.id}"
    post "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription3.id}"
    patch "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}"

    get "/api/v1/customers/#{customer1.id}/subscriptions"

    expect(response).to be_successful

    subscriptions = JSON.parse(response.body, symbolize_names: true)

    expect(subscriptions).to be_an(Array)

    subscriptions.each do |cs|
      expect(cs).to have_key(:id)
      expect(cs[:id]).to be_an(Integer)
      expect(cs).to have_key(:customer_id)
      expect(cs[:customer_id]).to be_an(Integer)
      expect(cs).to have_key(:subscription_id)
      expect(cs[:subscription_id]).to be_an(Integer)
      expect(cs).to have_key(:status)
      expect(cs[:status]).to be_a(String)
    end
    expect(subscriptions.first[:status]).to eq("active")
    expect(subscriptions.last[:status]).to eq("canceled")
  end
end
