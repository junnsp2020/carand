require 'test_helper'

class Users::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_products_new_url
    assert_response :success
  end

  test "should get index" do
    get users_products_index_url
    assert_response :success
  end

  test "should get show" do
    get users_products_show_url
    assert_response :success
  end

  test "should get create" do
    get users_products_create_url
    assert_response :success
  end

  test "should get edit" do
    get users_products_edit_url
    assert_response :success
  end

  test "should get update" do
    get users_products_update_url
    assert_response :success
  end

  test "should get destroy" do
    get users_products_destroy_url
    assert_response :success
  end

end
