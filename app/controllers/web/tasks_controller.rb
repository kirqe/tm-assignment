class Web::TasksController < ApplicationController
  before_filter :authenticate_user
  before_action :set_task, only: [:show, :update, :start, :finish]
  def index
    if (params[:user_id])
      @tasks = Task.where(user_id: params[:user_id])
    else
      @tasks = Task.all
    end
  end

  def show
  end

  def update
    respond_to do |format|
      if @task.update_attributes(task_params)
        format.html
        format.js
        format.json { render json: @task, notice: 'updated'}
      else
        format.js
        format.json { render json: @task, status: :unprocessable_entity }
      end
    end
  end

  def start
    @task.start!
  end

  def finish
    @task.finish!
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :state)
  end
end
