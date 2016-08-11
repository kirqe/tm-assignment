require 'rails_helper'

RSpec.describe Task, :type => :model do
  it { should belong_to :user }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }

  it "has a valid factory" do
    user = FactoryGirl.create(:user, role: 'user')
    FactoryGirl.create(:task, user: user).should be_valid
  end
end
