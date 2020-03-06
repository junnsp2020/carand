require 'test_helper'

class Users::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_reviews_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_reviews_destroy_url
    assert_response :success
  end

end
