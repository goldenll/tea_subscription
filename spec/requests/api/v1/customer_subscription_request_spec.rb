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

    expect(cs).to have_key(:subscription)
    expect(cs[:subscription]).to be_a(Hash)
    expect(cs[:subscription]).to have_key(:id)
    expect(cs[:subscription]).to have_key(:title)
    expect(cs[:subscription]).to have_key(:price)
    expect(cs[:subscription]).to have_key(:status)
    expect(cs[:subscription]).to have_key(:frequency)
    expect(cs[:subscription]).to have_key(:customer_subscriptions)
    expect(cs[:subscription][:customer_subscriptions]).to_not be(nil)
  end

  xit "a customer can cancel a tea subscription" do
    subscription1 = create(:subscription)
    customer1 = create(:customer)

    delete "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}"

    expect(response).to be_successful

    # subscriptions = JSON.parse(response.body, symbolize_names: true)

    # expect(subscriptions).to be_an(Array)
    # expect(subscriptions[0]).to have_key(:id)
    # expect(subscriptions[0][:id]).to be_an(Integer)
    # expect(subscriptions[0]).to have_key(:title)
    # expect(subscriptions[0][:title]).to be_a(String)
    # expect(subscriptions[0]).to have_key(:price)
    # expect(subscriptions[0][:price]).to be_a(Float)
    # expect(subscriptions[0]).to have_key(:status)
    # expect(subscriptions[0][:status]).to be_a(String)
    # expect(subscriptions[0]).to have_key(:frequency)
    # expect(subscriptions[0][:frequency]).to be_a(String)
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