# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @task = tasks(:one)
    @group = groups(:one)
    sign_in users(:one)
  end

  test 'index page does not exist and raises error' do
    assert_raise ActionController::RoutingError do
      get group_tasks_path(@group.id)
    end
  end

  test 'should get new' do
    get new_group_task_url(@group.id)
    assert_response :success
  end

  test 'should create task' do
    assert_difference('Task.count') do
      post group_tasks_path(@group), params: { task: { description: @task.description, title: @task.title, group: @group, due_date: Date.today } }
    end

    assert_redirected_to group_path(@group)
  end

  test 'should show task' do
    get group_task_path(@group, @task)
    assert_response :success
  end

  test 'should get edit' do
    get edit_group_task_path(@group, @task)
    assert_response :success
  end

  test 'should update task' do
    patch group_task_path(@group, @task), params: { task: { description: @task.description, title: @task.title } }
    assert_redirected_to group_task_path(@task)
  end

  test 'should destroy task' do
    assert_difference('Task.count', -1) do
      delete group_task_path(@group, @task)
    end

    assert_redirected_to group_path(@group)
  end

  test 'claim assigns current task to current user' do
    assert_nil(@task.current_instance.user)

    put group_task_claim_path(@group, @task), params: {}

    assert_equal(@task.current_instance.user, users(:one))
    assert_redirected_to group_task_path(@group, @task)
  end

  test 'claim does nothing if current instance is done' do
    task = tasks(:two)
    assert_nil(task.current_instance.user)

    put group_task_claim_path(@group, task), params: {}

    assert_nil(task.current_instance.user)
    assert_redirected_to group_task_path(@group, task)
  end

  test 'claim_all assigns task to current user' do
    assert_nil(@task.user)

    put group_task_claim_all_path(@group, @task), params: {}
    @task.reload

    assert_equal(@task.user, users(:one))
    assert_redirected_to group_task_path(@group, @task)
  end

  test 'claim_all does nothing if current instance is done' do
    task = tasks(:two)
    assert_nil(task.current_instance.user)

    put group_task_claim_path(@group, task), params: {}
    @task.reload

    assert_nil(task.current_instance.user)
    assert_redirected_to group_task_path(@group, task)
  end
end
