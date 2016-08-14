require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  let(:user) { FactoryGirl.create(:user, role: 'user') }
  let(:admin) { FactoryGirl.create(:user, role: 'admin') }

  describe "admin?" do
    it "returns true if current_user is admin" do
      @current_user = admin
      expect(@current_user.is_admin?).to be true
    end
    it "returns false if current_user is not admin" do
      @current_user = user
      expect(@current_user.is_admin?).to be false
    end
  end
end
