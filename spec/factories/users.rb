# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider 'google'
    sequence(:uid)
    sequence(:name) {|n| "user_#{n}" }
  end
end
