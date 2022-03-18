class UserGroupAssignmentsController < ApplicationController
  before_action :set_user_group_assignment, only: %i[ show edit update ]

  def new
  end

  def create
    if params.key?(:group)
      group = Group.find(params[:group][:id])
      user = User.where({email: params[:group][:email]}).first
    else
      group = Group.where('title = ?', params[:title]).first
      user = current_user
    end

    if group and user
      if not user.groups.where({id: group.id}).empty?
        flash[:alert] = "User is are already a member of #{group.title}"
        redirect_to groups_path
      else
        assignment = UserGroupAssignment.new(user_id: user.id, group_id: group.id)
        if assignment.save
          flash[:alert] = "Successfully added to #{group.title}"
          redirect_to groups_path
        end
      end
    end
    
    if not flash[:alert]
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