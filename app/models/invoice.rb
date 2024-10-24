class Invoice < ApplicationRecord
  def total
    if tax.present?
      amount * (1 + (tax / 100))
    else
      amount
    end
  end
end
