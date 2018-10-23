module Gateway
  require 'stripe'
  class Package

    def initialize(package_id)
      @package_id = package_id
    end 

    def get_package
     begin
        @package_details = Stripe::Plan.retrieve(@package_id)
        return @package_details
      rescue
        false
      end
    end    

  end

end