# frozen_string_literal: true

10.times do
  Invoice.create client_name: Faker::Name.name,
                 amount: Faker::Number.decimal(l_digits: 3, r_digits: 2),
                 tax: [nil, 8, 12, 30].sample
end
