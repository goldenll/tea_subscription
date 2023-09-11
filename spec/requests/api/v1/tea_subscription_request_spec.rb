require 'rails_helper'

describe "Tea Subscription API" do
  it "allows a customer to subscribe to a tea service" do
    create(:subscription)

    get '/api/v1/subscription'

    expect(response).to be_successful
  end
end