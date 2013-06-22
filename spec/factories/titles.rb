# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :title do
    sequence(:name) { |n| "title_#{n}" }
    sequence(:kana) { |n| "kana_#{n}" }
  end
end
