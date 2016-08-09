class Web::Admin::TasksController < ApplicationController
  before_filter :authenticate_user
  before_action :set_task, only: [:show, :update, :start, :finish]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task }
        format.json { render json: @task }
      else
        format.html { render 'new' }
        format.json { render json: @task.errorsk, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :state, :attachment, :user_id)
  end

end
