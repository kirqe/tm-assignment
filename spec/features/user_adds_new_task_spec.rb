require 'rails_helper'

RSpec.describe "Checkingout user' tasks", :type => :feature do
  before(:each) do
    @user1 = FactoryGirl.create(:user, role: 'user')
    @admin = FactoryGirl.create(:user, role: 'admin')
  end

  scenario "task has valid inputs" do
    visit login_path
    fill_in "Email", with: @user1.email
    fill_in "Password", with: @user1.password
    click_button "Login"

    click_link "+ New Task"
    fill_in "Name", with: "my new task"
    fill_in "Description", with: "this is a new task"
    click_button "Create Task"

    page.should have_content('Task was successfully created')
    @user1.tasks.length.should eq(1)
  end

  scenario "task has invalid inputs" do
    visit login_path
    fill_in "Email", with: @user1.email
    fill_in "Password", with: @user1.password
    click_button "Login"

    click_link "+ New Task"
    fill_in "Name", with: ""
    fill_in "Description", with: "this is a new task"
    click_button "Create Task"

    page.should_not have_content('Task was successfully created')
    @user1.tasks.length.should eq(0)
  end

  scenario "admin adds task to other user" do
    visit login_path
    fill_in "Email", with: @admin.email
    fill_in "Password", with: @admin.password
    click_button "Login"

    click_link "+ New Task"
    fill_in "Name", with: "my new task"
    fill_in "Description", with: "this is a new task"
    select "#{@user1.email}", from: 'task_user_id'
    click_button "Create Task"

    page.should have_content('Task was successfully created.')
    @user1.tasks.length.should eq(1)
  end
end
