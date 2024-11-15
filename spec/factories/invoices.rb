# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    client
    amount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    tax { Faker::Number.between(from: 1, to: 20) }
  end
end
