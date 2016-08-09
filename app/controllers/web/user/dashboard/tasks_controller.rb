class Web::User::Dashboard::TasksController < ApplicationController
  before_filter :authenticate_user
  before_action :set_task, only: [:show, :start, :finish]
  def index
    if (params[:user_id])
      @tasks = Task.where(user_id: params[:user_id]).page params[:page]
    else
      @tasks = Task.all.page params[:page]
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = @current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to dashboard_user_task_path(@task.user_id, @task) }
        format.json { render json: @task }
      else
        format.html { render 'new' }
        format.json { render json: @task.errorsk, status: :unprocessable_entity }
      end
    end
  end

  def show
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
    params.require(:task).permit(:name, :description, :state, :attachment)
  end
end
