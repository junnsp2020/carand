require 'test_helper'

class Users::TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_transactions_new_url
    assert_response :success
  end

  test "should get index" do
    get users_transactions_index_url
    assert_response :success
  end

  test "should get show" do
    get users_transactions_show_url
    assert_response :success
  end

  test "should get create" do
    get users_transactions_create_url
    assert_response :success
  end

  test "should get edit" do
    get users_transactions_edit_url
    assert_response :success
  end

  test "should get update" do
    get users_transactions_update_url
    assert_response :success
  end

end
