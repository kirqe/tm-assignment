require 'rails_helper'

RSpec.feature "Checkingout user' tasks", :type => :feature do
  before(:each) do
    @user1 = FactoryGirl.create(:user, role: 'user')
    @user2 = FactoryGirl.create(:user, role: 'user')
    @admin = FactoryGirl.create(:user, role: 'admin')
    4.times {
      FactoryGirl.create(:task, user_id: @user1.id)
    }
  end

  scenario "task belongs to current_user", js: true do
    visit login_path
    fill_in "Email", :with => @user1.email
    fill_in "Password", :with => @user1.password
    click_button "Login"
    visit dashboard_user_tasks_path(@user1)
    page.first('a.check').click
    page.should have_content('started')
  end

  scenario "task doesn't belong to current_user", js: true do
    visit login_path
    fill_in "Email", :with => @user2.email
    fill_in "Password", :with => @user2.password
    click_button "Login"
    visit dashboard_user_tasks_path(@user1)
    page.should_not have_css('a.check')
  end

  scenario "current user is admin", js: true do
    visit login_path
    fill_in "Email", :with => @admin.email
    fill_in "Password", :with => @admin.password
    click_button "Login"
    page.first('a.check').click
    page.should have_content('started')
  end
end
