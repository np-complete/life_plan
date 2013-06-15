# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_channel do
    user
    channel
  end
end
