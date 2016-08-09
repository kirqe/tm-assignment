class Web::TasksController < ApplicationController
    before_action :authenticate_user
    before_action :set_task, only: [:start, :finish]

    def index
      if logged_in?
        if admin?
          redirect_to admin_dashboard_tasks_path
        else
          redirect_to dashboard_tasks_path
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
end
