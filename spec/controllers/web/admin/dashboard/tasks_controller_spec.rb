require 'rails_helper'

RSpec.describe Web::Admin::Dashboard::TasksController, :type => :controller do
  let(:user) { FactoryGirl.create(:user, role: 'user') }
  let(:task) { FactoryGirl.create(:task, user_id: user.id) }
  let(:admin_user) { FactoryGirl.create(:user, role: 'admin') }
  before(:each) do
    login_as(admin_user)
  end

  describe "GET #index" do
    it "assigns all tasks to @tasks" do
      get :index
      expect(assigns(:tasks)).to eq([task])
    end

    it "renders :index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "assigns the selected task to @task" do
      get :show, params: { id: task }
      expect(assigns(:task)).to eq(task)
    end

    it "render :show view" do
      get :show, params: { id: task }
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    it "assigns a new task to @task" do
      get :new
      expect(assigns(:task)).to be_a_new(Task)
    end

    it "renders new method" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "POST #create" do
    context "when task attributes are valid" do
      let(:valid_attributes) { FactoryGirl.attributes_for(:task, user_id: user.id) }

      it "creates a new task" do
        expect{
           post :create, params: { task: valid_attributes }
        }.to change(user.tasks, :count).by(1)
      end

      it "redirects to task details page" do
        post :create, params: { task: valid_attributes }
        expect(response).to redirect_to admin_dashboard_task_path(Task.last)
      end
    end

    context "when task attributes are invalid" do
      let(:invalid_attributes) { FactoryGirl.attributes_for(:task) }

      it "doesn't save a new task" do
        expect{
          post :create, params: { task: invalid_attributes }
        }.to_not change(Task, :count)
      end

      it "renders new action" do
        post :create, params: { task: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    before(:each) do
      @task = FactoryGirl.create(:task, user_id: user.id, name: "task 1")
    end

    context "when new attributes are valid" do
      let(:valid_attributes) { FactoryGirl.attributes_for(:task, user_id: user.id, name: "task 2") }

      it "changes @task attributes" do
        put :update, params: { id: @task, task: valid_attributes }
        @task.reload
        @task.name.should eq("task 2")
      end

      it "redirects to @task updated page" do
        put :update, params: { id: @task, task: valid_attributes }
        expect(response).to redirect_to(admin_dashboard_task_path(@task))
      end
    end

    context "when new attributes are invalid" do
      let(:invalid_attributes) { FactoryGirl.attributes_for(:task, user_id: user.id, name: "") }

      it "it doesn't change @task's attributes" do
        put :update, params: { id: @task, task: invalid_attributes }
        @task.reload
        @task.name.should eq("task 1")
      end

      it "renders renders edit medhod" do
        put :update, params: { id: @task, task: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @task = FactoryGirl.create(:task, user_id: user.id)
    end

    it "deletes task" do
      expect{
        delete :destroy, params: { id: @task }
      }.to change(Task, :count).by(-1)
    end

    it "redirects to tasks page" do
      delete :destroy, params: { id: @task }
      expect(response).to redirect_to(admin_dashboard_tasks_path)
    end
  end
end
