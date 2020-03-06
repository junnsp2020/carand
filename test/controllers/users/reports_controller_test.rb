require 'test_helper'

class Users::ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_reports_new_url
    assert_response :success
  end

  test "should get create" do
    get users_reports_create_url
    assert_response :success
  end

end
