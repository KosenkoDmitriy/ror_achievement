# frozen_string_literal: true

class Achievement < ApplicationRecord
  validates :title, presence: true
  enum privacy: %i[public_access private_access friend_access]

  def description_markdown
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
  end
end
