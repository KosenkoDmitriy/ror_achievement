require "rails_helper"

feature "achievement page" do
  scenario "show" do
    achievement = FactoryBot.create(:achievement, title: "We can do it")
    visit(achievement_url(achievement.id))
    expect(page).to have_content("We can do it")

    # achievements = create_list(:public_achievement, 3)
    # p achievements
  end
  scenario "render markdown description" do
    achievement = create(:achievement, description: "Achievement *Description*")
    visit(achievement_url(achievement))
    # expect(page).to have_content("Achievement <em>Description</em>") # for raw html
    expect(page).to have_css("em", text: "Description")
  end
end
