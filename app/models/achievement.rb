# frozen_string_literal: true

class Achievement < ApplicationRecord # ActiveRecord::Base
  belongs_to :user, required: false
  validates :user, presence: true

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

  def title_by_email
    "#{title} by #{user.email}"
  end

  def self.by_letter(letter)
    includes(:user).where('title like ?', "#{letter}%").order('users.email')
  end
  
  def self.get_public_achievements
  end
  
  private

  def unique_title_for_one_user
    existing_achievement = Achievement.find_by(title: title) # Achievement.where(title: title).first
    if (existing_achievement && existing_achievement.user == user)
      errors.add(:title, "you can't have two achievements with the same title")
    end
  end
  

end
