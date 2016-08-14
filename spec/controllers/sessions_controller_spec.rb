require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user, role: 'user') }

  describe "GET #new" do
    context "when user logged in" do
      it "redirect to root_url" do
        login_as(user)
        get :new
        expect(response).to redirect_to(root_url)
      end
    end

    context "when user is not logged in" do
      it "renders new method" do
        get :new
        expect(response).to render_template('new')
      end
    end
  end

  describe "POST #create" do
    context "when attributes are valid" do
      it "creates a new session" do
        post :create, params: {
          session:{
            email: user.email,
            password: user.password
          }
        }
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects user to dasboard" do
        post :create, params: {
          session:{
            email: user.email,
            password: user.password
          }
        }
        expect(response).to redirect_to(dashboard_user_tasks_path(user))
      end
    end

    context "when attributes are invalid" do
      it "doesn't create a new session" do
        post :create, params: {
          session:{
            email: "user@example.com",
            password: user.password
          }
        }
        expect(session[:user_id]).to be(nil)
      end
      it "renders new method" do
        post :create, params: {
          session:{
            email: "user@example.com",
            password: user.password
          }
        }
        expect(response).to render_template('new')
      end
    end
  end

  describe "POST destroy" do
    before(:each) do
      login_as(user)
    end

    it "clears session" do
      post :destroy
      expect(session[:user_id]).to eq(nil)
    end

    it "redirects user to login page" do
      post :destroy
      expect(response).to redirect_to(login_path)
    end
  end
end
