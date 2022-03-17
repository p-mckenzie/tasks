class UserGroupAssignmentsController < ApplicationController
  before_action :set_user_group_assignment, only: %i[ show edit update ]

  def new
  end

  def create
    group = Group.where('title = ?', params[:title]).first
    if group
      if not current_user.groups.where(id: group.id).empty?
        flash[:alert] = "You are already a member of #{group.title}"
        redirect_to groups_path
      else
        assignment = UserGroupAssignment.new(user_id: current_user.id, group_id: group.id)
        assignment.save
        flash[:alert] = "Successfully joined #{group.title}"
        redirect_to groups_path
      end
    else
      flash[:alert] = 'Unable to create group membership'
      redirect_to groups_path
    end
  end

  def destroy
    assignment = UserGroupAssignment.find(params[:id])
    if assignment.delete
      flash[:alert] = 'Successfully removed user from group'
    else
      flash[:alert] = 'Something went wrong'
    end
    redirect_to groups_path
  end
end