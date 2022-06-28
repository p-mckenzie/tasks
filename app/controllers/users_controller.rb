# frozen_string_literal: true

class UsersController < ApplicationController
  def edit; end

  def update; end

  def my_tasks
    @tasks = current_user.current_tasks
  end
end
