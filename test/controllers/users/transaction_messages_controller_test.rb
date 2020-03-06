require 'test_helper'

class Users::TransactionMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_transaction_messages_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_transaction_messages_destroy_url
    assert_response :success
  end

end
