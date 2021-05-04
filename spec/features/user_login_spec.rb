require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do
  before :each do
    @user = User.create!(
      first_name: "Test",
      last_name: "User",
      email: "sample@text.com", 
      password: "hunter2!"
      )
  end

  scenario "They can login with an existing user" do
    visit new_users_session_path
    fill_in "Email", with: "sample@text.com"
    fill_in "Password", with: "hunter2!"
    find(".btn").click
    expect(page).to have_content 'Logout'
  end
end
