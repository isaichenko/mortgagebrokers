require './test/test_helper'

class UserTest < ActiveSupport::TestCase
  test "should save user" do
    user = User.new(first_name: 'Test',
      last_name: 'User', 
      email: 'test_user1@gmail.com',
      password: 'r123456',
      password_confirmation: 'r123456',
      role_id: 3
      )
    assert user.save
  end
  test "should not save user without first name" do
    user = User.new(
      last_name: 'User', 
      email: 'test_user1@gmail.com',
      password: 'r123456',
      password_confirmation: 'r123456',
      role_id: 3
      )
    assert !user.save
  end
  test "should not save user without last name" do
    user = User.new(
      first_name: 'User', 
      email: 'test_user1@gmail.com',
      password: 'r123456',
      password_confirmation: 'r123456',
      role_id: 3
      )
    assert !user.save
  end  
end
