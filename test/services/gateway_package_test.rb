require './test/test_helper'

class GatewayPackageTest < ActiveSupport::TestCase
  test 'it retieves stripe plan with given package' do
    package_id = 'package-test-3'
    plan = Gateway::Package.new(package_id).get_package
    assert plan
  end
end