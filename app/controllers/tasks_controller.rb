# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy complete_instance claim claim_all]
  before_action :set_group, only: %i[new edit show update create complete_instance claim claim_all]

  def claim_all
    @task.user = current_user
    @task.save

    redirect_to group_task_path(@group, @task)
  end

  def claim
    unless @task.current_instance.complete
      task_instance = @task.current_instance
      task_instance.user = current_user
      task_instance.save
    end

    redirect_to group_task_path(@group, @task)
  end

  # GET /tasks/1 or /tasks/1.json
  def show; end

  # GET /tasks/new
  def new
    @task = Task.new(group_id: group_id)
  end

  # GET /tasks/1/edit
  def edit; end

  def complete_instance
    task_instance = @task.current_instance
    task_instance.user = current_user
    task_instance.complete = true

    unless task_instance.save
      flash[:alert] = 'Error completing task'
      go_to_task
    end

    @task.next_task_instance if @task.recurring?

    redirect_to group_task_path(@group, @task)
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.group_id = group_id

    respond_to do |format|
      if @task.save
        format.html { redirect_to group_path(@group), notice: 'Task was successfully created.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to group_task_path(id: @task.id), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to group_path, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params.permit(:id)[:id])
  end

  def set_group
    @group = Group.find(group_id)
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :recurrence_type, :separation, :user_id,
                                 :visibility_delay, :quantity, :repeat_until)
  end

  def group_id
    params.permit(:group_id)[:group_id]
  end

end
