require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:tasks) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
end
