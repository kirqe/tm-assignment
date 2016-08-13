require 'rails_helper'

RSpec.describe Web::User::Dashboard::TasksController, :type => :controller do
  let(:user) { FactoryGirl.create(:user, role: 'user') }
  let(:task) { FactoryGirl.create(:task, user_id: user.id) }
  before(:each) do
    login_as(user)
  end

  describe "GET #index" do

    it "assigns all tasks to @tasks" do
      get :index
      expect(assigns(:tasks)).to eq([task])
    end

    it "renders :index view" do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe "GET #show" do
    it "assigns the selected task to @task" do
      get :show, id: task
      expect(assigns(:task)).to eq(task)
    end

    it "renders :show view" do
      get :show, id: task
      expect(response).to render_template('show')
    end
  end

  describe "GET #new" do
    it "assigns a new task to @task" do
      get :new
      expect(assigns(:task)).to be_a_new(Task)
    end

    it "renders :new method" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "POST #create" do
    context "when task attributes are valid" do
      it "crates a new task to current user" do
        expect{
           post :create, task: FactoryGirl.attributes_for(:task, user_id: user.id)
        }.to change(user.tasks, :count).by(1)
      end

      it "redirects to created task details page" do
        post :create, task: FactoryGirl.attributes_for(:task, user_id: user.id)
        expect(response).to redirect_to dashboard_user_task_path(user, user.tasks.last)
      end
    end

    context "when task attributes are invalid" do
      it "doesn't save a new task" do
        expect{
          post :create, task: FactoryGirl.attributes_for(:task, name: "")
        }.to_not change(Task, :count)
      end

      it "renders new action" do
        post :create, task: FactoryGirl.attributes_for(:task, name: "")
        expect(response).to render_template("new")
      end
    end
  end
end
