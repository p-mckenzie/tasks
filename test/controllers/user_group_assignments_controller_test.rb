# frozen_string_literal: true

require 'test_helper'

class UserGroupAssignmentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @group = groups(:one)
  end

  # TODO
end
