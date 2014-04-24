FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@testing.com"
  end
  factory :user do
    email
    password "password"
    password_confirmation "password"
  end
end
