require 'test_helper'

class Users::BlogCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_blog_comments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_blog_comments_destroy_url
    assert_response :success
  end

end
