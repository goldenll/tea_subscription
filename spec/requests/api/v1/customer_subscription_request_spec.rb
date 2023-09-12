require 'rails_helper'

describe "Customer Subscription API" do
  it "a customer can subscribe to a tea subscription" do
    subscription1 = create(:subscription)
    customer1 = create(:customer)

    post "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}"

    expect(response).to be_successful

    cs = JSON.parse(response.body, symbolize_names: true)

    expect(cs).to be_a(Hash)
    expect(cs).to have_key(:customer)
    expect(cs[:customer]).to be_a(Hash)
    expect(cs[:customer]).to have_key(:id)
    expect(cs[:customer]).to have_key(:first_name)
    expect(cs[:customer]).to have_key(:last_name)
    expect(cs[:customer]).to have_key(:email)
    expect(cs[:customer]).to have_key(:address)
    expect(cs[:customer]).to have_key(:customer_subscriptions)
    expect(cs[:customer][:customer_subscriptions]).to_not be(nil)
    expect(cs[:customer][:customer_subscriptions]).to be_an(Array)
    expect(cs[:customer][:customer_subscriptions][0]).to have_key(:id)
    expect(cs[:customer][:customer_subscriptions][0][:id]).to be_an(Integer)
    expect(cs[:customer][:customer_subscriptions][0]).to have_key(:customer_id)
    expect(cs[:customer][:customer_subscriptions][0][:customer_id]).to be_an(Integer)
    expect(cs[:customer][:customer_subscriptions][0][:customer_id]).to eq(cs[:customer][:id])
    expect(cs[:customer][:customer_subscriptions][0]).to have_key(:subscription_id)
    expect(cs[:customer][:customer_subscriptions][0][:subscription_id]).to be_an(Integer)

    expect(cs).to have_key(:subscription)
    expect(cs[:subscription]).to be_a(Hash)
    expect(cs[:subscription]).to have_key(:id)
    expect(cs[:subscription]).to have_key(:title)
    expect(cs[:subscription]).to have_key(:price)
    expect(cs[:subscription]).to have_key(:status)
    expect(cs[:subscription]).to have_key(:frequency)
    expect(cs[:subscription]).to have_key(:customer_subscriptions)
    expect(cs[:subscription][:customer_subscriptions]).to_not be(nil)
    expect(cs[:subscription][:customer_subscriptions]).to be_an(Array)
    expect(cs[:subscription][:customer_subscriptions][0]).to have_key(:id)
    expect(cs[:subscription][:customer_subscriptions][0][:id]).to be_an(Integer)
    expect(cs[:subscription][:customer_subscriptions][0]).to have_key(:subscription_id)
    expect(cs[:subscription][:customer_subscriptions][0][:subscription_id]).to be_an(Integer)
    expect(cs[:subscription][:customer_subscriptions][0][:subscription_id]).to eq(cs[:subscription][:id])
    expect(cs[:subscription][:customer_subscriptions][0]).to have_key(:subscription_id)
    expect(cs[:subscription][:customer_subscriptions][0][:subscription_id]).to be_an(Integer)
  end

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

    expect(CustomerSubscription.all.count).to eq(4)

    delete "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}"

    expect(response).to be_successful
    done = JSON.parse(response.body, symbolize_names: true)

    expect(CustomerSubscription.all.count).to eq(3)

    expect(done).to be_a(Hash)
    expect(done).to have_key(:message)
    expect(done[:message]).to be_a(String)
    expect(done[:message]).to eq("Subscription successfully canceled")
  end

  xit "returns a customers subscription history" do
    customer1 = create(:customer)

    get "/api/v1/customers/#{customer1.id}/subscriptions}"

    expect(response).to be_successful

    customers = JSON.parse(response.body, symbolize_names: true)

    # expect(customers).to be_an(Array)
    # expect(customers[0]).to have_key(:id)
    # expect(customers[0][:id]).to be_an(Integer)
    # expect(customers[0]).to have_key(:first_name)
    # expect(customers[0][:first_name]).to be_a(String)
    # expect(customers[0]).to have_key(:last_name)
    # expect(customers[0][:last_name]).to be_a(String)
    # expect(customers[0]).to have_key(:email)
    # expect(customers[0][:email]).to be_a(String)
    # expect(customers[0]).to have_key(:address)
    # expect(customers[0][:address]).to be_a(String)
  end
end