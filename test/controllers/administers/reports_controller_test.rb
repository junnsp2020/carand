require 'test_helper'

class Administers::ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get administers_reports_index_url
    assert_response :success
  end

  test "should get show" do
    get administers_reports_show_url
    assert_response :success
  end

  test "should get destroy" do
    get administers_reports_destroy_url
    assert_response :success
  end

end
