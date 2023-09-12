class Api::V1::CustomerSubscriptionsController < ApplicationController
  def create
    cs1 = CustomerSubscription.create(customer_subscription_params)
    if cs1.save
        render json: { customer: cs1.customer, subscription: cs1.subscription }, status: :created
    else
      render json: {error: cs1.errors.full_messages.to_sentence}, status: :unprocessable_entity
    end
  end

  private 
  def customer_subscription_params
    params.permit(:customer_id, :subscription_id)
  end
end