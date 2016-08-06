class Web::TasksController < ApplicationController
  before_action :set_task, only: [:show]
  def index
    if (params[:user_id])
      @tasks = Task.where(user_id: params[:user_id])
    else
      @tasks = Task.all
    end
  end

  def show
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end
end
