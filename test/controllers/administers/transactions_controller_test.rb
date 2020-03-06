require 'test_helper'

class Administers::TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get administers_transactions_index_url
    assert_response :success
  end

  test "should get show" do
    get administers_transactions_show_url
    assert_response :success
  end

  test "should get edit" do
    get administers_transactions_edit_url
    assert_response :success
  end

  test "should get update" do
    get administers_transactions_update_url
    assert_response :success
  end

  test "should get destroy" do
    get administers_transactions_destroy_url
    assert_response :success
  end

end
