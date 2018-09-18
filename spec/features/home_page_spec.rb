require "rails_helper"

feature "home page" do
  scenario "welcome page" do
    visit("/")
    expect(page).to have_content("welcome")
  end
end
