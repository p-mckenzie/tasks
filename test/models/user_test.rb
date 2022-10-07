# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include ActiveSupport::Testing::TimeHelpers
  setup do
    @user = users(:one)
    @group = groups(:one)
  end

  test 'Full name renders correctly' do
    assert_equal @user.full_name, 'Jane Doe'
  end

  test 'admin? returns true if user is an admin' do
    assert @user.admin?(@group)
  end

  test 'admin? returns false if user is not an admin' do
    assert !@user.admin?(groups(:two))
  end

  test 'current_tasks returns correct tasks' do
    assert @user.current_tasks.include?(task_instances(:two))
  end

  test 'current_tasks ignores complete tasks' do
    assert @user.current_tasks.exclude?(task_instances(:one))
  end

  test 'current_tasks ignores tasks outside visible window' do
    travel_to Date.new(2022, 1, 1)
    assert @user.current_tasks.exclude?(task_instances(:four))
  end

  test 'current_tasks includes tasks inside visible window' do
    travel_to Date.new(2022, 2, 1)
    assert @user.current_tasks.include?(task_instances(:four))
  end
end
