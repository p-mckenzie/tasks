class UserGroupAssignmentsController < ApplicationController
  before_action :set_user_group_assignment, only: %i[ show edit update destroy ]

  # GET /user_group_assignments or /user_group_assignments.json
  def index
    @user_group_assignments = UserGroupAssignment.all
  end

  # GET /user_group_assignments/1 or /user_group_assignments/1.json
  def show
  end

  # GET /user_group_assignments/new
  def new
    @user_group_assignment = UserGroupAssignment.new
  end

  # GET /user_group_assignments/1/edit
  def edit
  end

  # POST /user_group_assignments or /user_group_assignments.json
  def create
    @user_group_assignment = UserGroupAssignment.new(user_group_assignment_params)

    respond_to do |format|
      if @user_group_assignment.save
        format.html { redirect_to user_group_assignment_url(@user_group_assignment), notice: "User group assignment was successfully created." }
        format.json { render :show, status: :created, location: @user_group_assignment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_group_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_group_assignments/1 or /user_group_assignments/1.json
  def update
    respond_to do |format|
      if @user_group_assignment.update(user_group_assignment_params)
        format.html { redirect_to user_group_assignment_url(@user_group_assignment), notice: "User group assignment was successfully updated." }
        format.json { render :show, status: :ok, location: @user_group_assignment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_group_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_group_assignments/1 or /user_group_assignments/1.json
  def destroy
    @user_group_assignment.destroy

    respond_to do |format|
      format.html { redirect_to user_group_assignments_url, notice: "User group assignment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_group_assignment
      @user_group_assignment = UserGroupAssignment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_group_assignment_params
      params.fetch(:user_group_assignment, {})
    end
end
