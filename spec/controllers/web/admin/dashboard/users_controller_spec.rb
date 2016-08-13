require 'rails_helper'

RSpec.describe Web::Admin::Dashboard::UsersController, :type => :controller do
  let(:admin_user) {FactoryGirl.create(:user, role: 'admin')}
  let(:user) {FactoryGirl.create(:user, role: 'user')}
  before(:each) do
    login_as(admin_user)
  end

  describe "GET #index" do
    it "assigns all users to @users" do
      get :index
      expect(assigns(:users)).to eq([admin_user, user])
    end

    it "renders :index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the selected user to @user" do
      get :show, id: user
      expect(assigns(:user)).to eq(user)
    end

    it "renders :show view" do
      get :show, id: user
      expect(response).to render_template('show')
    end
  end

  describe "GET #new" do
    it "assign a new user to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders new method" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "POST #create" do
    context "when user attributes are valid" do
      it "creates a new user" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "redirects to created user page" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to admin_dashboard_user_path(User.last)
      end
    end

    context "when user attributes are invalid" do
      it "doesn't save a new user" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user, email: "")
        }.to_not change(User, :count)
      end

      it "renders new method" do
        post :create, user: FactoryGirl.attributes_for(:user, email: "")
        expect(response).to render_template('new')
      end
    end
  end

  describe "PUT #update" do
    before(:each) do
      @user = FactoryGirl.create(:user, role: 'user', email: "user1@example.com")
    end

    context "when new attributes are valid" do
      it "changes @user's attributes" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, email: "newemail@example.com")
        @user.reload
        expect(@user.email).to eq("newemail@example.com")
      end

      it "redirects to @user updated page" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, email: "newemail@example.com")
        expect(response).to redirect_to(admin_dashboard_user_path(@user))
      end
    end

    context "when new attributes are invalid" do
      it "doesnt change @user's attributes" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, email: "")
        @user.reload
        expect(@user.email).to eq("user1@example.com")
      end

      it "renders edit methond" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, email: "")
        expect(response).to render_template('edit')
      end
    end
  end

  describe "DELETE #delete" do
    before(:each) do
      @user = FactoryGirl.create(:user, role: 'user')
    end

    it "deletes user" do
      expect{
        delete :destroy, id: @user
      }.to change(User, :count).by(-1)
    end

    it "redirect to users page" do
      delete :destroy, id: @user
      expect(response).to redirect_to(admin_dashboard_users_path)
    end
  end
end
