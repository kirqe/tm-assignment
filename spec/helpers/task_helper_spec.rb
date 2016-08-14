require 'rails_helper'

RSpec.describe TasksHelper, :type => :helper do
  let(:user1) { FactoryGirl.create(:user, role: 'user') }
  let(:user2) { FactoryGirl.create(:user, role: 'user') }
  let(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let(:task) { FactoryGirl.create(:task, user_id: user1.id) }

  describe "task_controlls(task)" do
    context "when task belongs to current_user" do
      it "returns controlls for task" do
        @current_user = user1
        controlls = task_controlls(task)
        controlls.should have_css("i", "fa-play")
      end
    end

    context "when task doesn't belong to current_user" do
      it "doesn't return controlls for task" do
        @current_user = user2
        controlls = task_controlls(task)
        controlls.should_not have_css("i", "fa-play")
      end
    end

    context "when current_user is admin" do
      it "doesn't return controlls for task" do
        @current_user = admin
        controlls = task_controlls(task)
        controlls.should have_css("i", "fa-play")
      end
    end
  end

  describe "state_color(task)" do
    context "task was just created" do
      it "returns 'info' class" do
        expect(state_color(task)).to include("info")
      end
    end

    context "task was started" do
      it "returns 'success' class" do
        task.start!
        expect(state_color(task)).to include("success")
      end
    end

    context "task was finished" do
      it "returns 'default' class" do
        task.start!
        task.finish!
        expect(state_color(task)).to include("default")
      end
    end
  end

  # how can this be improved?
  describe "attachment(task) " do
    it "return image if file has 'jpg jpeg gif png' extensions" do
      task = FactoryGirl.create(:task, user_id: user1.id,
       attachment: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'attachments', 'image.png')) )
      expect(attachment(task)).to have_css("img") # right here......??
    end

    it "return a link if file has 'pdf doc docx txt' extensions" do
      task = FactoryGirl.create(:task, user_id: user1.id,
       attachment: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'attachments', 'test.txt')) )
       expect(attachment(task)).to_not have_css("img") # and here......??
    end
  end

  describe "has_attachment?(task)" do
    it "returns attachment icon if file attached" do
      task = FactoryGirl.create(:task, user_id: user1.id,
       attachment: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'attachments', 'image.png')) )
       expect(has_attachment?(task)).to have_css("i", "fa-paperclip")
    end

    it "doesn't return attachment icon if file is not attached" do
       expect(has_attachment?(task)).to_not have_css("i", "fa-paperclip")
    end
  end
end
