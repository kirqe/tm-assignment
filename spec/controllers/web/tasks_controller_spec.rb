require 'rails_helper'

RSpec.describe Web::TasksController, :type => :controller do
  let(:user1) { FactoryGirl.create(:user, role: 'user') }
  let(:user2) { FactoryGirl.create(:user, role: 'user') }
  let(:admin_user) { FactoryGirl.create(:user, role: 'admin') }

  describe "GET #index" do
    context "when user logged in as admin" do
      before(:each) do
        login_as(admin_user)
      end

      it "redirects admin user to admin_dashboard_tasks" do
        get :index
        expect(response).to redirect_to admin_dashboard_tasks_url
      end
    end

    context "when user logged in as a regular user" do
      before(:each) do
        login_as(user1)
      end

      it "redirects a regular user to dashboard_user_tasks_path" do
        get :index
        expect(response).to redirect_to dashboard_user_tasks_path(user1)
      end
    end

    context "when user is not logged in" do
      it "redirects to login page" do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "PUT #start" do
    let(:task) { FactoryGirl.create(:task, user_id: user1.id) }

    context "when task belongs to the current user" do
      before(:each) do
        login_as(user1)
      end

      it "change the state of task to started" do
        put :start, params: { id: task }
        task.reload
        expect(task.state).to eq "started"
      end
    end

    context "when task doesn't belong to the current user" do
      before(:each) do
        login_as(user2)
      end

      it "change the state of task to started" do
        put :start, params: { id: task }
        task.reload
        expect(task.state).to eq "new"
      end
    end

    context "when current user is admin" do
      before(:each) do
        login_as(admin_user)
      end

      it "change the state of task to started" do
        put :start, params: { id: task }
        task.reload
        expect(task.state).to eq "started"
      end
    end
  end

  describe "PUT #finish" do
    let(:task) { FactoryGirl.create(:task, user_id: user1.id, state: "started") }

    context "when task belongs to the current user" do
      before(:each) do
        login_as(user1)
      end

      it "change the state of task to started" do
        put :finish, params: { id: task }
        task.reload
        expect(task.state).to eq "finished"
      end
    end

    context "when task doesn't belong to the current user" do
      before(:each) do
        login_as(user2)
      end

      it "change the state of task to started" do
        put :finish, params: { id: task }
        task.reload
        expect(task.state).to eq "started"
      end
    end

    context "when current user is admin" do
      before(:each) do
        login_as(admin_user)
      end

      it "change the state of task to started" do
        put :finish, params: { id: task }
        task.reload
        expect(task.state).to eq "finished"
      end
    end
  end
end
