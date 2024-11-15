# frozen_string_literal: true

# Model for Invoice entity
class Invoice < ApplicationRecord
  acts_as_paranoid

  validates :client_name, presence: true, uniqueness: { allow_blank: true, conditions: -> { where(deleted_at: nil) } }
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :tax, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  def total
    if tax.present?
      amount * (1 + (tax / 100))
    else
      amount
    end
  end
end
