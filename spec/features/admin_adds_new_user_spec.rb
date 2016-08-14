require 'rails_helper'

RSpec.describe "Checkingout user' tasks", :type => :feature do
  before(:each) do
    @admin = FactoryGirl.create(:user, role: 'admin')
  end
  scenario "user has valid inputs" do
    visit login_path
    fill_in "Email", with: @admin.email
    fill_in "Password", with: @admin.password
    click_button "Login"

    click_link "Users"
    click_link "Add new user"
    fill_in "Email", with: "newuser@email.com"
    fill_in "Password", with: "12345678"
    select "user", from: "user_role"
    click_button "Create User"

    page.should have_content('User was successfully created.')
    User.all.length.should eq(2)
  end

  scenario "user has valid inputs" do
    visit login_path
    fill_in "Email", with: @admin.email
    fill_in "Password", with: @admin.password
    click_button "Login"

    click_link "Users"
    click_link "Add new user"
    fill_in "Email", with: ""
    fill_in "Password", with: "12345678"
    select "user", from: "user_role"
    click_button "Create User"

    page.should_not have_content('User was successfully created.')
    User.all.length.should eq(1)
  end
end
