# frozen_string_literal: true

class UserGroupAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :group
end
