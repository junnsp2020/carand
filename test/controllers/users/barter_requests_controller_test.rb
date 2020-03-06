require 'test_helper'

class Users::BarterRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_barter_requests_index_url
    assert_response :success
  end

  test "should get show" do
    get users_barter_requests_show_url
    assert_response :success
  end

  test "should get create" do
    get users_barter_requests_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_barter_requests_destroy_url
    assert_response :success
  end

end
