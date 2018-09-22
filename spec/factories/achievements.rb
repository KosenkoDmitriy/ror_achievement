# frozen_string_literal: true

FactoryBot.define do
  factory :achievement do
    # title { "Title" }
    sequence(:title) { |n| "Achievement #{n}" }
    description { 'Description' }
    featured { false }
    cover_image { "#{Rails.root}/fixtures/cover_image.png" }

    factory :public_achievement do
      privacy { :public_access }
    end

    factory :private_achievement do
      privacy { :private_access }
    end
  end
end
