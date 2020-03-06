require 'test_helper'

class Administers::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get administers_categories_index_url
    assert_response :success
  end

  test "should get create" do
    get administers_categories_create_url
    assert_response :success
  end

  test "should get edit" do
    get administers_categories_edit_url
    assert_response :success
  end

  test "should get update" do
    get administers_categories_update_url
    assert_response :success
  end

end
