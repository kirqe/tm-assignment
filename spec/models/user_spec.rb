require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:tasks) }
  it { should validate_presence_of :email }
  it { should validate_length_of(:email).is_at_most(255)}
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(6)}

  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  describe "is_admin?" do
    context "when user is admin" do
      let(:user){ FactoryGirl.create(:user, role: 'admin') }
      it "returns true if user is admin" do
        expect(user.is_admin?).to be true
      end
    end

    context "when user is not admin" do
      let(:user){ FactoryGirl.create(:user, role: 'user') }
      it "returns false if user is not admin" do
        expect(user.is_admin?).to be false
      end
    end
  end
end
