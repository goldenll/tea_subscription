require 'rails_helper'

describe "Customer API" do
  it "returns a customers information" do
    create(:customer)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body, symbolize_names: true)

    expect(customers).to be_an(Array)
    expect(customers[0]).to have_key(:id)
    expect(customers[0][:id]).to be_an(Integer)
    expect(customers[0]).to have_key(:first_name)
    expect(customers[0][:first_name]).to be_a(String)
    expect(customers[0]).to have_key(:last_name)
    expect(customers[0][:last_name]).to be_a(String)
    expect(customers[0]).to have_key(:email)
    expect(customers[0][:email]).to be_a(String)
    expect(customers[0]).to have_key(:address)
    expect(customers[0][:address]).to be_a(String)
  end

  # it "can have multiple tea subscriptions" do
  #   create_list(:subscription, 3)

  #   get '/api/v1/subscriptions'

  #   expect(response).to be_successful

  #   subscriptions = JSON.parse(response.body, symbolize_names: true)

  #   expect(subscriptions.count).to eq(3)

  #   subscriptions.each do |subscription|
  #     expect(subscription).to have_key(:id)
  #     expect(subscription[:id]).to be_an(Integer)
  #     expect(subscription).to have_key(:title)
  #     expect(subscription[:title]).to be_a(String)
  #     expect(subscription).to have_key(:price)
  #     expect(subscription[:price]).to be_a(Float)
  #     expect(subscription).to have_key(:status)
  #     expect(subscription[:status]).to be_a(String)
  #     expect(subscription).to have_key(:frequency)
  #     expect(subscription[:frequency]).to be_a(String)
  #   end
  # end
end