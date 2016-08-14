require 'rails_helper'

RSpec.describe SessionsHelper, :type => :helper do
  let(:user) { FactoryGirl.create(:user, role: 'user') }

  describe "log_in(user)" do
    it "writes user id to session" do
      log_in(user)
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe "current_user" do
    context "@current is empty" do
      it "sets itself to session[:user_id]" do
        log_in(user)
        expect(current_user).to eq(user)
      end
    end
    context "@current is not empty" do
      it "returns itself" do
        @current_user = user
        expect(current_user).to eq(user)
      end
    end

  end

  describe "logged_in?" do
    it "returns true if logged in" do
      log_in(user)
      expect(logged_in?).to be(true)
    end

    it "returns false if not logged in" do
      expect(logged_in?).to be(false)
    end
  end

  describe "log_out" do
    it "sets session[:user_id] to nil" do
      log_in(user)
      log_out
      expect(session[:user_id]).to be_nil
    end

    it "sets @current_user to nil" do
      log_in(user)
      log_out
      expect(@current_user).to be_nil
    end
  end
end
