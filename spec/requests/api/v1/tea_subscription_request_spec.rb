require 'rails_helper'

describe "Tea Subscription API" do
  it "exists" do
    create(:subscription)

    get '/api/v1/subscriptions'

    expect(response).to be_successful

    subscriptions = JSON.parse(response.body, symbolize_names: true)

    expect(subscriptions).to be_an(Array)
    expect(subscriptions[0]).to have_key(:id)
    expect(subscriptions[0][:id]).to be_an(Integer)
    expect(subscriptions[0]).to have_key(:title)
    expect(subscriptions[0][:title]).to be_a(String)
    expect(subscriptions[0]).to have_key(:price)
    expect(subscriptions[0][:price]).to be_a(Float)
    expect(subscriptions[0]).to have_key(:frequency)
    expect(subscriptions[0][:frequency]).to be_a(String)
  end

  it "multiple tea subscriptions can exist" do
    create_list(:subscription, 3)

    get '/api/v1/subscriptions'

    expect(response).to be_successful

    subscriptions = JSON.parse(response.body, symbolize_names: true)

    expect(subscriptions.count).to eq(3)

    subscriptions.each do |subscription|
      expect(subscription).to have_key(:id)
      expect(subscription[:id]).to be_an(Integer)
      expect(subscription).to have_key(:title)
      expect(subscription[:title]).to be_a(String)
      expect(subscription).to have_key(:price)
      expect(subscription[:price]).to be_a(Float)
      expect(subscription).to have_key(:frequency)
      expect(subscription[:frequency]).to be_a(String)
    end
  end
end