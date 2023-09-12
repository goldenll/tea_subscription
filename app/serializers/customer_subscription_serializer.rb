class CustomerSubscriptionSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :email, :address, :title, :price, :status, :frequency
end