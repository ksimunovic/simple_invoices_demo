# frozen_string_literal: true

# Model for Client entity
class Client < ApplicationRecord
  # acts_as_paranoid

  has_many :invoices, dependent: :destroy

  validates :name, presence: true, uniqueness: {allow_blank: true}
end
