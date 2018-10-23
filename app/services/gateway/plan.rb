module Gateway
  require 'stripe'
  class Plan

    def initialize(user,token)
      @user = user 
      @token = token
    end 

    def add_new_card
      begin
        customer = Stripe::Customer.retrieve(Gateway::Customer.new(@user).add_new_customer())
        customer.sources.create({:source => @token})
      rescue
        false
      end
    end 

  end

end