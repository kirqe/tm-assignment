class Web::Admin::Dashboard::TasksController < Web::Admin::AdminController
  before_action :set_task, only: [:show, :update, :start, :finish]
  before_action :authenticate_user
  before_filter :authorize_user
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

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :state, :attachment, :user_id)
  end

end
