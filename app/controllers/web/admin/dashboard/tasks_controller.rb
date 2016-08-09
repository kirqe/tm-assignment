class Web::Admin::Dashboard::TasksController < ApplicationController
  before_filter :authenticate_user
  before_action :set_task, only: [:show, :update, :start, :finish]

  def index
    @tasks = Task.all.page params[:page]
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to admin_dashboard_task_path(@task) }
        format.json { render json: @task }
      else
        format.html { render 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def start
    if (@task.user == current_user || @current_user.is_admin?)
      @task.start!
    else
      render json: @task, status: :unprocessable_entity
    end
  end

  def finish
    if (@task.user == current_user || @current_user.is_admin?)
      @task.finish!
    else
      render json: @task, status: :unprocessable_entity
    end
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :state, :attachment, :user_id)
  end

end
