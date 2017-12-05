FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "name#{n}" }
    sequence(:login) { |n| "login#{n}" }
    sequence(:email) { |n| "email#{n}@getchinahome.com" }
    password 'password'
    password_confirmation 'password'
    created_at 100.days.ago
  end
end
