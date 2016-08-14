require 'rails_helper'

RSpec.describe Task, :type => :model do
  it { should belong_to :user }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }

  it "has a valid factory" do
    user = FactoryGirl.create(:user, role: 'user')
    FactoryGirl.create(:task, user: user).should be_valid
  end

  describe "task state" do
    user = FactoryGirl.create(:user, role: 'user')
    task = FactoryGirl.create(:task, user: user)

    it "has state 'new' when just created" do
      expect(task.state).to eq("new")
    end

    it "has state 'started' after starting" do
      task.start!
      expect(task.state).to eq("started")
    end

    it "has state 'finished' after finishing" do
      task.finish!
      expect(task.state).to eq("finished")
    end
  end

end
