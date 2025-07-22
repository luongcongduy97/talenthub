FactoryBot.define do
  factory :employee do
    association :company
    association :user
    sequence(:name) { |n| "Employee #{n}" }
    position { "Developer" }
  end
end
