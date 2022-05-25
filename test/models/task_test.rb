# frozen_string_literal: true

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  setup do
    @task = Task.create(title: 'Test', description: '', due_date: DateTime.parse('2022-01-07'), group: Group.new)
  end

  test 'new task exists and is valid' do
    assert_exists @task
  end

  test 'new task has a task instance' do
    assert_not_empty @task.task_instances
  end
end
