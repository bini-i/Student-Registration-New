require "test_helper"

class SectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sections_index_url
    assert_response :success
  end

  test "should get change_section" do
    get sections_change_section_url
    assert_response :success
  end

  test "should get handle_section_change" do
    get sections_handle_section_change_url
    assert_response :success
  end
end
