module Gateway
  require 'stripe'
  class Customer

    def initialize(user)
      @user = user
    end 

    def add_new_customer
      begin
        customer = Stripe::Customer.create(description: "Customer: #{@user.email}")
        @user.update_attributes(stripe_customer_id: customer.id)
        return customer.id 
      rescue
        false
      end
    end        

  end
end