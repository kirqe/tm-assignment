class Web::Tasks::TasksController < ApplicationController
  def index
    @tasks = Task.all
    respond_to do |format|
      format.html { render 'web/tasks/index' }
      format.json { render json: @tasks }
    end
  end
end
