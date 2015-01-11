# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :title do
    sequence(:name) { |n| "title_#{n}" }
    sequence(:kana) { |n| "kana_#{n}" }

    media_id 1

    trait :anime do
      media_id 1
    end

    trait :radio do
      media_id 2
    end

    trait :movie do
      media_id 8
    end
  end
end
