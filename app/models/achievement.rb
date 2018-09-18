class Achievement < ApplicationRecord
  validates :title, presence: true
  enum privacy: [:public_access, :private_access, :friend_access]

  def description_markdown
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(self.description)
  end
end
