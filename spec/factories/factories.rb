# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |n| "test#{n}@test.com" }
  sequence(:name) { |n| "Simon Enterprises (#{n})" }

  factory :user do
    email
    name "Simon Cyberpunk"
  end

  factory :campaign do
    name
    memberships { [FactoryGirl.build(:membership)] }
  end

  factory :membership do
    user
  end
end
