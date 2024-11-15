# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    sequence(:name) { |n| "#{Faker::Company.name} #{n}" }
  end
end
