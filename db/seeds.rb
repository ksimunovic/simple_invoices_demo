# frozen_string_literal: true

20.times do
  Invoice.create(client: Client.create(name: Faker::Company.name),
    amount: Faker::Number.decimal(l_digits: 3, r_digits: 2),
    tax: [nil, 8, 12, 30].sample)
end

User.create!(email: "admin@designfiles", password: "designfiles", password_confirmation: "designfiles")
