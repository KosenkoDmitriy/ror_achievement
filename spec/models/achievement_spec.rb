# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Achievement, type: :model do
  describe 'validations' do
    it 'requires title' do
      achievement = Achievement.new(title: '')
      achievement.valid?
      expect(achievement.errors[:title]).to include("can't be blank")
      # expect(achievement.title).not_to be_empty
      expect(achievement.valid?).to be_falsy # eq(false)
    end
    it { should validate_presence_of(:title) }

    it 'requires title to be unique for one user' do
      user = create(:user)
      first_achievement = create(:public_achievement, title: 'first', user: user)
      # new_achievement = build(:public_achievement, title: 'first', user: user)
      new_achievement = Achievement.new(title: 'first', user: user)
      expect(new_achievement.valid?).to eq(false)
    end

    it 'allows different users to have achievements with identical titles' do
      user1 = create(:user)
      user2 = create(:user)
      achievement1 = create(:achievement, user: user1, title: 'title')
      # achievement2 = create(:achievement, user: user2, title: 'title')
      achievement2 = Achievement.new(user: user2, title: 'title')
      expect(achievement1.title).to eq(achievement2.title)
      expect(achievement2.valid?).to be_truthy # eq(true)
    end

    it { should validate_uniqueness_of(:title).scoped_to(:user_id).with_message("you can't have two achievements with the same title") }
  end


  it 'belongs to user' do
    achievement = Achievement.new(title: 'title', user: nil)
    expect(achievement.valid?).to eq(false)
  end
  
  it { 
    # is_expected.not_to validate_presence_of(:user) 
    should validate_presence_of(:user)
  }

  it 'has belongs_to user association' do
    # 1 approach
    user = create(:user)
    achievement = create(:public_achievement, user: user)
    expect(achievement.user).to eq(user)

    # 2 approach
    u = Achievement.reflect_on_association(:user)
    expect(u.macro).to eq(:belongs_to)

  end

  it { should belong_to(:user) } # or it { is_expected.to belong_to(:user) }
end
