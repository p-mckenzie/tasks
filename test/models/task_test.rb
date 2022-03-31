require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "new task gets a task instance" do
    task = Task.new()

    assert_equal agreement.acceptance, event.model
  end
end
