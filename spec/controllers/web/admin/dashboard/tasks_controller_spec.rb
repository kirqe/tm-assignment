require 'rails_helper'

RSpec.describe Web::Admin::Dashboard::TasksController, :type => :controller do

  #GET index
  describe "GET #index" do
    let(:user) { FactoryGirl.create(:user, role: 'user') }
    let(:task) { FactoryGirl.create(:task, user_id: user.id) }

    context "when user is authenticated as ADMIN" do
      before(:each) do
        admin_user = FactoryGirl.create(:user, role: 'admin')
        login_as(admin_user)
      end

      it "assigns @tasks" do
        get :index
        expect(assigns(:tasks)).to eq([task])
      end

      it "renders :index template" do
        get :index
        expect(response).to render_template("index")
      end
    end

    context "when user is authenticated as a REGULAR USER" do
      before(:each) do
        user = FactoryGirl.create(:user, role: 'user')
        login_as(user)
      end

      it "redirects a regular user to user's dashboard" do
        get :index
        expect(response).to redirect_to dashboard_tasks_path
      end
    end

    context "when user is not authenticated" do
      it "redirects user to login_path" do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  #GET show
  describe "GET #show" do
    let(:user) { FactoryGirl.create(:user, role: 'user') }
    let(:task) { FactoryGirl.create(:task, user_id: user.id) }
    let(:admin_user) { FactoryGirl.create(:user, role: 'admin') }
    before(:each) do
      login_as(admin_user)
    end

    it "render :show template" do
      get :show, id: task
      expect(response).to render_template("show")
    end

    it "assigns @task to template" do
      get :show, id: task
      expect(assigns(:task)).to eq(task)
    end
  end

  #GET new
  describe "GET #new" do
    let(:admin_user) { FactoryGirl.create(:user, role: 'admin') }
    before(:each) do
      login_as(admin_user)
    end

    context "when user logged in as ADMIN" do
      it "assigns a new task to @task" do
        get :new
        expect(assigns(:task)).to be_a_new(Task)
      end
    end
  end

  #POST create
  describe "POST #create" do
    let(:admin_user) { FactoryGirl.create(:user, role: 'admin') }
    let(:user) { FactoryGirl.create(:user, role: 'user') }
    let(:valid_task) { FactoryGirl.attributes_for(:task, user_id: user.id) }
    let(:invalid_task) { FactoryGirl.attributes_for(:task) }
    before(:each) do
      login_as(admin_user)
    end

    context "when task is valid" do
      it "adds a new task to selected user" do
        expect{
           post :create, task: valid_task
        }.to change(user.tasks, :count).by(1)
      end
      it "redirects to task details page" do
        post :create, task: valid_task
        expect(response).to redirect_to admin_dashboard_task_path(user.tasks.last)
      end
    end

    context "when task is invalid" do
      it "renders new action" do
        post :create, task: invalid_task
        expect(response).to render_template("new")
      end
    end
  end

  #PUT update
  describe "PUT #update" do
    let(:admin_user) { FactoryGirl.create(:user, role: 'admin') }

    before(:each) do
      @user = FactoryGirl.create(:user, role: 'user')
      @task = FactoryGirl.create(:task, user_id: @user.id)
      login_as(admin_user)
    end
    context "when task is valid" do
      it "updates the task successfully" do

        put :update, id: @task, task: FactoryGirl.attributes_for(:task, name: "qqqqqqqq")
        @task.reload
        @task.name.should eq("qqqqqqqq")
      end

    end
    context "when task is invalid" do
      it "renders renders template edit" do
        put :update, id: @task, task: FactoryGirl.attributes_for(:task, name: "")
        expect(response).to render_template('edit')
      end
    end
  end

  #DELETE delete
  describe "DELETE #destroy" do
    let(:admin_user) { FactoryGirl.create(:user, role: 'admin') }
    
    before(:each) do
      @user = FactoryGirl.create(:user, role: 'user')
      @task = FactoryGirl.create(:task, user_id: @user.id)
      login_as(admin_user)
    end
    it "deletes task successfully" do
      expect{
        delete :destroy, id: @task
      }.to change(Task, :count).by(-1)
    end
  end


end
