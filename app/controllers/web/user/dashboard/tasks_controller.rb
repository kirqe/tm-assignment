class Web::User::Dashboard::TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: [:show, :start, :finish]

  def index
    if (params[:user_id])
      @tasks = Task.sort_by_user_and_date(params[:user_id]).page params[:page]
    else
      @tasks = Task.sort_by_date.page params[:page]
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = @current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to dashboard_user_task_path(@task.user_id, @task), notice: "Task was successfully created." }
        format.json { render json: @task }
      else
        format.html { render 'new' }
        format.json { render json: @task.errorsk, status: :unprocessable_entity }
      end
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
