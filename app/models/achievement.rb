# frozen_string_literal: true

class Achievement < ApplicationRecord # ActiveRecord::Base
  belongs_to :user, required: false
  validates :user, presence: false

  validates :title, presence: true
  # validates :title, uniqueness: true
  # validate :unique_title_for_one_user
  validates :title, uniqueness: {
    scope: :user_id,
    message: "you can't have two achievements with the same title"
  }
  
  # enum privacy: %i[public_access private_access friend_access]
  enum privacy: [ :public_access, :private_access, :friend_access ]

  def description_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
  end

  private

  def unique_title_for_one_user
    existing_achievement = Achievement.find_by(title: title) # Achievement.where(title: title).first
    if (existing_achievement && existing_achievement.user == user)
      errors.add(:title, "you can't have two achievements with the same title")
    end
  end

end
