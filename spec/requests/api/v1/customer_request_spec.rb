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
end