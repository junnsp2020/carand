require 'test_helper'

class Users::FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_favorites_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_favorites_destroy_url
    assert_response :success
  end

end
