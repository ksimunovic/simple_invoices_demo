# frozen_string_literal: true

# spec/models/invoice_spec.rb
require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:valid_attributes) { { client_name: 'John Doe', amount: 100, tax: 10 } }
  let(:invoice) { described_class.new(valid_attributes) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(invoice).to be_valid
    end

    it 'is invalid without a client_name' do
      invoice.client_name = nil
      expect(invoice).not_to be_valid
    end

    it 'is invalid with duplicate client_name' do
      described_class.create!(valid_attributes)
      duplicate_invoice = described_class.new(valid_attributes)
      expect(duplicate_invoice).not_to be_valid
    end

    it 'is valid with duplicate client_name if previous record is deleted' do
      described_class.create!(valid_attributes).destroy # Soft delete the invoice
      duplicate_invoice = described_class.new(valid_attributes)
      expect(duplicate_invoice).to be_valid
    end

    it 'is invalid without an amount' do
      invoice.amount = nil
      expect(invoice).not_to be_valid
    end

    it 'is invalid with a negative amount' do
      invoice.amount = -1
      expect(invoice).not_to be_valid
    end

    it 'is invalid with a negative tax' do
      invoice.tax = -1
      expect(invoice).not_to be_valid
    end

    it 'is valid with nil tax' do
      invoice.tax = nil
      expect(invoice).to be_valid
    end

    it 'is valid with a zero tax' do
      invoice.tax = 0
      expect(invoice).to be_valid
    end
  end

  describe '#total' do
    it 'returns the amount if tax is nil' do
      invoice.tax = nil
      expect(invoice.total).to eq(100)
    end

    it 'calculates total with tax' do
      expect(invoice.total).to eq(110.0) # 100 + 10% of 100
    end

    it 'calculates total with 0% tax' do
      invoice.tax = 0
      expect(invoice.total).to eq(100)
    end
  end
end