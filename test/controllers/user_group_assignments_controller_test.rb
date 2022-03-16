require "test_helper"

class UserGroupAssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_group_assignment = user_group_assignments(:one)
  end

  test "should get index" do
    get user_group_assignments_url
    assert_response :success
  end

  test "should get new" do
    get new_user_group_assignment_url
    assert_response :success
  end

  test "should create user_group_assignment" do
    assert_difference('UserGroupAssignment.count') do
      post user_group_assignments_url, params: { user_group_assignment: {  } }
    end

    assert_redirected_to user_group_assignment_url(UserGroupAssignment.last)
  end

  test "should show user_group_assignment" do
    get user_group_assignment_url(@user_group_assignment)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_group_assignment_url(@user_group_assignment)
    assert_response :success
  end

  test "should update user_group_assignment" do
    patch user_group_assignment_url(@user_group_assignment), params: { user_group_assignment: {  } }
    assert_redirected_to user_group_assignment_url(@user_group_assignment)
  end

  test "should destroy user_group_assignment" do
    assert_difference('UserGroupAssignment.count', -1) do
      delete user_group_assignment_url(@user_group_assignment)
    end

    assert_redirected_to user_group_assignments_url
  end
end
