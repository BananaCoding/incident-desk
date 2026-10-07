require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup { @user = users(:customer) }

  test "new renders the sign-in form" do
    get new_session_path

    assert_response :success
    assert_select "form[action=?]", session_path
    assert_select "input[type=email][name=email_address]"
    assert_select "input[type=password][name=password]"
    assert_select ".alert-error", count: 0
  end

  test "create with valid credentials redirects to the dashboard" do
    post session_path, params: { email_address: @user.email_address, password: "password" }

    assert_redirected_to root_path
    assert cookies[:session_id]
  end

  test "create matches email case-insensitively" do
    post session_path, params: { email_address: " CUSTOMER@example.com ", password: "password" }

    assert_redirected_to root_path
  end

  test "create returns to the originally requested page" do
    get root_path
    assert_redirected_to new_session_path

    post session_path, params: { email_address: @user.email_address, password: "password" }

    assert_redirected_to root_url
  end

  test "create with invalid password shows an error" do
    post session_path, params: { email_address: @user.email_address, password: "wrong" }

    assert_response :unprocessable_entity
    assert_select ".alert-error", "Invalid email or password"
    assert_select "input[name=email_address][value=?]", @user.email_address
    assert_nil cookies[:session_id]
  end

  test "create with unknown email shows the same error" do
    post session_path, params: { email_address: "nobody@example.com", password: "password" }

    assert_response :unprocessable_entity
    assert_select ".alert-error", "Invalid email or password"
  end

  test "destroy logs out" do
    sign_in_as(@user)

    delete session_path

    assert_redirected_to new_session_path
    assert_empty cookies[:session_id]

    get root_path
    assert_redirected_to new_session_path
  end
end
