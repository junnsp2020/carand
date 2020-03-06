require 'test_helper'

class Users::BlogFollowsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_blog_follows_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_blog_follows_destroy_url
    assert_response :success
  end

end
