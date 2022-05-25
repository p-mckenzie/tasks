# frozen_string_literal: true

class UserGroupAssignmentsController < ApplicationController
  before_action :set_user_group_assignment, only: %i[show edit update]
  before_action :assign_from_params, only: %i[create]

  def new; end

  def create
    if @target_group.users.include?(@target_user)
      flash[:alert] = "User is are already a member of #{@target_group.title}"
    else
      assignment = UserGroupAssignment.new(user_id: @target_user.id, group_id: @target_group.id)
      flash[:alert] = assignment.save ? "Successfully added to #{@target_group.title}" : 'Unable to create group membership'
    end

    redirect_to edit_group_path(@target_group)
  end

  def destroy
    assignment = UserGroupAssignment.find(params[:id])
    flash[:alert] = assignment.delete ? 'Successfully removed user from group' : 'Something went wrong'

    redirect_to edit_group_path(assignment.group)
  end

  private

  def assign_from_params
    if params.key?(:group)
      @target_group = Group.find(params[:group][:id])
      @target_user = User.where({ email: params[:group][:email] }).first
    else
      @target_group = Group.where('title = ?', params[:title]).first
      @target_user = current_user
    end
  end
end
