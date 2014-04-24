FactoryGirl.define do

  factory :article do
    sequence(:title) { |n| "Article-#{n}" }
    content "Back the truck up!"
  end
end
