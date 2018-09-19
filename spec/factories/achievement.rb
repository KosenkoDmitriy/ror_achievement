# frozen_string_literal: true

FactoryBot.define do
  factory :achievement do
    # title { "Title" }
    sequence(:title) { |n| "Achievement #{n}" }
    description { 'Description' }
    privacy { Achievement.privacies[:private_access] }
    featured { false }
    cover_image { "#{Rails.root}/fixtures/cover_image.png" }

    factory :public_achievement do
      privacy { Achievement.privacies[:public_access] }
    end
  end
end
