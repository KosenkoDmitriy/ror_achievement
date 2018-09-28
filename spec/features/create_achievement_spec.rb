# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/new_achievement_form'
require_relative '../support/login_form'

feature 'createn new achievement' do
  let(:new_achievement_form) { NewAchievementForm.new }
  let(:login_form) { LoginForm.new }
  let(:user) { create(:user) }

  background do # alias for feature
  # before do # alias for describe
    login_form.visit_page.login_as(user)
  end

  scenario 'create new achievement with valida data' do
    new_achievement_form.visit_page.fill_in_with(title: 'Read a book').submit

    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(ActionMailer::Base.deliveries.last.to).to include(user.email)
    expect(page).to have_content('Achievement has been created')
    expect(Achievement.last.title).to eq('Read a book')
  end

  scenario 'can not create achievement with invalid data' do
    new_achievement_form.visit_page.submit
    expect(page).to have_content('can\'t be blank')
  end
end
