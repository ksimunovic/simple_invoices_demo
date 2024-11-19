# frozen_string_literal: true

# Model for Invoice entity
class Invoice < ApplicationRecord
  acts_as_paranoid

  belongs_to :client

  validates :client, presence: true
  validates :amount, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :tax, numericality: {greater_than_or_equal_to: 0, allow_nil: true}

  def total
    tax.present? ? amount * (1 + (tax / 100)) : amount
  end

  def self.create_with_client(invoice_params)
    client = find_or_create_client(invoice_params)

    return {success: false, message: "Client information not found"} if client.nil?

    invoice = Invoice.new(invoice_params.except(:client_name).merge(client: client))

    save_invoice(invoice)
  end

  def self.save_invoice(invoice)
    if invoice.save
      {success: true, invoice: invoice}
    else
      {success: false, invoice: invoice}
    end
  rescue ActiveRecord::RecordInvalid => e
    {success: false, message: e.message}
  rescue => e
    {success: false, message: e.message}
  end

  def self.find_or_create_client(invoice_params)
    if invoice_params[:client_id].present?
      Client.find_by(id: invoice_params[:client_id]) || Client.create(name: invoice_params[:client_name])
    else
      Client.find_or_create_by(name: invoice_params[:client_name])
    end
  end
end
