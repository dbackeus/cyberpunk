# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |n| "test#{n}@gmail.com" }
  sequence(:name) { |n| "Simon Enterprises (#{n})" }

  factory :user do
    email
  end

  factory :campaign do
    name
    memberships { [FactoryGirl.build(:membership)] }
  end

  factory :membership do
    user
  end

  factory :role do
    sequence(:name) { |n| "Solo Version #{n}" }
  end

  factory :character do
    handle "Sweetness"
    role
  end
end
