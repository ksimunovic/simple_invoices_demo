# frozen_string_literal: true

# Adds deleted_at to invoices table for act_as_paranoid gem
class AddDeletedAtToInvoices < ActiveRecord::Migration[7.2]
  def change
    add_column :invoices, :deleted_at, :datetime
  end
end
