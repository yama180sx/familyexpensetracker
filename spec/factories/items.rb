FactoryBot.define do
  factory :item do
    receipt { nil }
    family { nil }
    name { "MyString" }
    price { "9.99" }
  end
end
