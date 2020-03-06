require 'test_helper'

class Users::TransfersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_transfers_show_url
    assert_response :success
  end

  test "should get create" do
    get users_transfers_create_url
    assert_response :success
  end

  test "should get edit" do
    get users_transfers_edit_url
    assert_response :success
  end

  test "should get update" do
    get users_transfers_update_url
    assert_response :success
  end

end
