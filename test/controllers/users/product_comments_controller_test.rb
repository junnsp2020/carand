require 'test_helper'

class Users::ProductCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_product_comments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_product_comments_destroy_url
    assert_response :success
  end

end
