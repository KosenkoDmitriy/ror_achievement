# frozen_string_literal: true

FactoryBot.define do
  factory :achievement do
    # title { "Title" }
    sequence(:title) { |n| "Achievement #{n}" }
    description { 'Description' }
    featured { false }
    cover_image { "#{Rails.root}/fixtures/cover_image.png" }

    # factory :achievement_with_user do
    # user's association
    user
    # association :user, factory: :user, strategy: :build #, email: 'Custom@email.ru'
    # end

    factory :public_achievement do
      privacy { :public_access }
    end

    factory :private_achievement do
      privacy { :private_access }
    end
  end
end
