# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :channel_group do
    sequence(:name) { |n| "channel_group_#{n}" }
  end
end
