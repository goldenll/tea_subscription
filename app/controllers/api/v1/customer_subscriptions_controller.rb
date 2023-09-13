class Api::V1::CustomerSubscriptionsController < ApplicationController
  def index
    if Customer.find(params[:customer_id]).customer_subscriptions != []
      render json: Customer.find(params[:customer_id]).customer_subscriptions, status: :ok
    else
      render json: { error: "No subscriptions found" }, status: :unprocessable_entity
    end
  end

  def create
    cs1 = CustomerSubscription.create(customer_subscription_params)
    if cs1.save
        render json: { customer: cs1.customer, subscription: cs1.subscription }, status: :created
    else
      render json: { error: cs1.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def update
    cs = CustomerSubscription.find_by(customer_id: params[:customer_id], subscription_id: params[:subscription_id])
    cs.update(status: 1)
    if cs.save
      render json: { message: "Subscription successfully canceled" }, status: :ok
    else 
      render json: { error: "Subscription not found" }, status: :unprocessable_entity
    end
  end

  def destroy
    cs = CustomerSubscription.find_by(customer_id: params[:customer_id], subscription_id: params[:subscription_id])
    if cs
      cs.destroy
      render json: {message: "Subscription successfully canceled"}, status: :ok
    else
      render json: {error: "Subscription not found"}, status: :not_found
    end
  end

  private 
  def customer_subscription_params
    params.permit(:customer_id, :subscription_id)
  end
end