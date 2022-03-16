require "application_system_test_case"

class UserGroupAssignmentsTest < ApplicationSystemTestCase
  setup do
    @user_group_assignment = user_group_assignments(:one)
  end

  test "visiting the index" do
    visit user_group_assignments_url
    assert_selector "h1", text: "User Group Assignments"
  end

  test "creating a User group assignment" do
    visit user_group_assignments_url
    click_on "New User Group Assignment"

    click_on "Create User group assignment"

    assert_text "User group assignment was successfully created"
    click_on "Back"
  end

  test "updating a User group assignment" do
    visit user_group_assignments_url
    click_on "Edit", match: :first

    click_on "Update User group assignment"

    assert_text "User group assignment was successfully updated"
    click_on "Back"
  end

  test "destroying a User group assignment" do
    visit user_group_assignments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User group assignment was successfully destroyed"
  end
end
