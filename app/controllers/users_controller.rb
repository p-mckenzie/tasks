class UsersController < ApplicationController

  def index
  end

  def edit
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to user_url(current_user), notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: current_user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def my_tasks
    @tasks = current_user.current_tasks
  end

end