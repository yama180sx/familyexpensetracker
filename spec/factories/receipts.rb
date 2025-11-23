FactoryBot.define do
  factory :receipt do
    transaction_date { "2025-10-28" }
    store_name { "MyString" }
    total_amount { "9.99" }
    image_url { "MyString" }
  end
end
