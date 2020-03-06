require 'test_helper'

class Users::WishlistsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_wishlists_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_wishlists_destroy_url
    assert_response :success
  end

end
