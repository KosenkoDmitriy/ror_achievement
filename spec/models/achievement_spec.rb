# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Achievement, type: :model do
  describe 'validations' do
    it 'requires title' do
      achievement = Achievement.new(title: '')
      achievement.valid?
      expect(achievement.errors[:title]).to include("can't be blank")
      # expect(achievement.title).not_to be_empty
      expect(achievement.valid?).to eq(false)
    end

    it 'requires title to be unique for one user' do
      user = create(:user)
      first_achievement = create(:public_achievement, title: 'first', user: user)
      new_achievement = build(:public_achievement, title: 'first', user: user)
      # new_achievement = Achievement.new(title: 'first', user: user)
      expect(new_achievement.valid?).to eq(false)
    end

    it 'allows different users to have achievements with identical titles' do
      user1 = create(:user)
      user2 = create(:user)
      achievement1 = create(:achievement, user: user1, title: 'title')
      achievement2 = create(:achievement, user: user2, title: 'title')
      expect(achievement1.title).to eq(achievement2.title)
      expect(achievement2.valid?).to be_truthy # eq(true)
    end
  end
end
