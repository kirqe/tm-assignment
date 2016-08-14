require 'rails_helper'

RSpec.describe "Logging in and out", :type => :feature do
  before(:each) do
    FactoryGirl.create(:user, email: "valid@example.com", password: "12345678")
  end

  scenario "with valid credentials" do
    visit login_path
    fill_in 'Email', with: "valid@example.com"
    fill_in 'Password', with: "12345678"
    click_button 'Login'
    expect(page).to have_content("Log out")
  end

  scenario "with invalid credentials" do
    visit login_path
    fill_in 'Email', with: "1valid@example.com"
    fill_in 'Password', with: "12345678"
    click_button 'Login'
    expect(page).to have_content('Invalid email or password')
  end

  scenario "logout" do
    visit login_path
    fill_in 'Email', with: "valid@example.com"
    fill_in 'Password', with: "12345678"
    click_button 'Login'
    click_link 'Log out'
    expect(page).to have_content("Logged out successfully")
  end
end
