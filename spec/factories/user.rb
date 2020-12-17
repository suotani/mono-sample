FactoryBot.define do
  factory :user, class: User do
    sequence(:name){|i| "user#{i}"}
  end
end