# frozen_string_literal: true

class Achievement < ApplicationRecord
  belongs_to :user, required: false
  validates :title, presence: true
  enum privacy: %i[public_access private_access friend_access]

  def description_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
  end
end
