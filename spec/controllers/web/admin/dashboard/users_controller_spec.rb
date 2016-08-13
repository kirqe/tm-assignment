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
      get :show, params: { id: user }
      expect(assigns(:user)).to eq(user)
    end

    it "renders :show view" do
      get :show, params: { id: user }
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
      let(:valid_attributes) { FactoryGirl.attributes_for(:user) }

      it "creates a new user" do
        expect{
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to created user page" do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to admin_dashboard_user_path(User.last)
      end
    end

    context "when user attributes are invalid" do
      let(:invalid_attributes) { FactoryGirl.attributes_for(:user, email: "") }

      it "doesn't save a new user" do
        expect{
          post :create, params: { user: invalid_attributes }
        }.to_not change(User, :count)
      end

      it "renders new method" do
        post :create, params: { user: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe "PUT #update" do
    before(:each) do
      @user = FactoryGirl.create(:user, role: 'user', email: "user1@example.com")
    end

    context "when new attributes are valid" do
      let(:valid_attributes) { FactoryGirl.attributes_for(:user, email: "newemail@example.com") }

      it "changes @user's attributes" do
        put :update, params: { id: @user, user: valid_attributes }
        @user.reload
        expect(@user.email).to eq("newemail@example.com")
      end

      it "redirects to @user updated page" do
        put :update, params: { id: @user, user: valid_attributes }
        expect(response).to redirect_to(admin_dashboard_user_path(@user))
      end
    end

    context "when new attributes are invalid" do
      let(:invalid_attributes) { FactoryGirl.attributes_for(:user, email: "") }

      it "doesnt change @user's attributes" do
        put :update, params: { id: @user, user: invalid_attributes }
        @user.reload
        expect(@user.email).to eq("user1@example.com")
      end

      it "renders edit methond" do
        put :update, params: { id: @user, user: invalid_attributes }
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
        delete :destroy, params: { id: @user }
      }.to change(User, :count).by(-1)
    end

    it "redirect to users page" do
      delete :destroy, params: { id: @user }
      expect(response).to redirect_to(admin_dashboard_users_path)
    end
  end
end
