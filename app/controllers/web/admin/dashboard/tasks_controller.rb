class Web::Admin::Dashboard::TasksController < Web::Admin::AdminController
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :authenticate_user
  before_filter :authorize_user

  def index
    if (params[:user_id])
      @tasks = Task.where(user_id: params[:user_id]).page params[:page]
    else
      @tasks = Task.all.page params[:page]
    end
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

  def edit
    @task = Task.find(params[:id])
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to admin_dashboard_task_path(@task) }
        format.json { render json: @task }
      else
        format.html { render 'edit' }
        format.json { render json: @task.errors, status: 'unprocessable_entity' }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to admin_dashboard_tasks_path }
      format.json { head :no_content }
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
