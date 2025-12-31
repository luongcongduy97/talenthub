FactoryBot.define do
  factory :notification do
    association :user

    # 1. Cập nhật tiếng Anh
    message { "You have a new notification" }

    # 2. Tạo URL duy nhất (Quan trọng để fix lỗi Capybara Ambiguous)
    # Nó sẽ sinh ra: /users/1, /users/2, /users/3...
    sequence(:url) { |n| "#notification-#{n}" }

    read_at { nil }
  end
end
