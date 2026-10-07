require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "requires sign in" do
    get root_path

    assert_redirected_to new_session_path
  end

  test "customer sees their dashboard with a log out button" do
    sign_in_as users(:customer)

    get root_path

    assert_response :success
    assert_select "h1", "My tickets"
    assert_select ".topbar .user", /customer@example\.com · Customer/
    assert_select ".topbar form[action=?] button", session_path, text: "Log out"
  end

  test "agent sees all tickets heading" do
    sign_in_as users(:agent)

    get root_path

    assert_response :success
    assert_select "h1", "All tickets"
    assert_select ".topbar .user", /agent@example\.com · Agent/
  end
end
