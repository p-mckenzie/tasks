# frozen_string_literal: true

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  setup do
    @task = tasks(:one)
  end

  test 'new task has a task instance' do
    assert_not_empty @task.task_instances
  end
end
