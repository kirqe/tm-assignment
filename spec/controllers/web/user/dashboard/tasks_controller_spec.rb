require 'rails_helper'

RSpec.describe Web::User::Dashboard::TasksController, :type => :controller do
  let(:user) { FactoryGirl.create(:user, role: 'user') }
  let(:task) { FactoryGirl.create(:task, user_id: user.id) }
  before(:each) do
    login_as(user)
  end

  describe "GET #index" do

    it "assigns @users" do
      get :index
      expect(assigns(:tasks)).to eq([task])
    end

    it "renders :index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "render :show template" do
      get :show, id: task
      expect(response).to render_template("show")
    end

    it "assigns @task to template" do
      get :show, id: task
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "GET #new" do
    it "assigns a new task to @task" do
      get :new
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe "POST #create" do
    context "when task is valid" do
      it "adds a new task to curren user" do
        expect{
           post :create, task: FactoryGirl.attributes_for(:task, user_id: user.id)
        }.to change(user.tasks, :count).by(1)
      end

      it "redirects to task details page" do
        post :create, task: FactoryGirl.attributes_for(:task, user_id: user.id)
        expect(response).to redirect_to dashboard_user_task_path(user, user.tasks.last)
      end
    end

    context "when task is invalid" do
      it "renders new action" do
        post :create, task: FactoryGirl.attributes_for(:task, user_id: user.id, name: "")
        expect(response).to render_template("new")
      end
    end
  end
end
