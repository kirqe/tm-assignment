class Web::TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
end
