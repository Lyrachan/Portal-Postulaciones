require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  # Test Funcional
  test "should get index" do
    get pages_index_url
    assert_response :success
  end
end
