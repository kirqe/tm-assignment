require 'rails_helper'

RSpec.describe Web::Admin::Dashboard::TasksController, :type => :controller do

  describe "GET index" do
    let(:user) { FactoryGirl.create(:user, role: 'user') }
    let(:task) { FactoryGirl.create(:task, user_id: user.id) }

    context "when user authenticated as admin" do
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

    context "when user authenticated as a regular user" do
      before(:each) do
        user = FactoryGirl.create(:user, role: 'user')
        login_as(user)
      end

      it "redirects a regular user to user's dashboard" do
        get :index
        expect(response).to redirect_to dashboard_tasks_path
      end
    end

    context "when user not authenticated" do
      it "redirects user to login_path" do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET show" do
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

  # describe "GET new" do
  #   let(:user) { FactoryGirl.create(:user, role: 'user') }
  #   let(:task) { FactoryGirl.create(:task, user_id: user.id) }
  #   it "assigns task details to @task" do
  #     get :new
  #
  #   end
  # end

end
