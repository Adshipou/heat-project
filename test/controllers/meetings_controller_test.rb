require "test_helper"

class MeetingsControllerTest < ActionDispatch::IntegrationTest
  test "redirects to login page if not authenticated" do
    get meetings_path
    assert_redirected_to login_path
  end

  test "renders the index template if authenticated" do
    session[:authenticated] = true
    get meetings_path
    assert_response :success
    assert_template :index
  end
end
