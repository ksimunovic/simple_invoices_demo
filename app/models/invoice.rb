# frozen_string_literal: true

# Model for Invoice entity
class Invoice < ApplicationRecord
  acts_as_paranoid

  belongs_to :client

  validates :client, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :tax, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  def total
    tax.present? ? amount * (1 + (tax / 100)) : amount
  end
end
