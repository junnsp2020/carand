require 'test_helper'

class Administers::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get administers_users_index_url
    assert_response :success
  end

  test "should get show" do
    get administers_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get administers_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get administers_users_update_url
    assert_response :success
  end

  test "should get destroy" do
    get administers_users_destroy_url
    assert_response :success
  end

end
