# frozen_string_literal: true

# Creates invoices table
class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.string :client_name, null: false
      t.decimal :amount, precision: 10, scale: 2, default: '0.0', null: false
      t.decimal :tax, precision: 10, scale: 2

      t.timestamps
    end

    add_index :invoices, :client_name, unique: true
  end
end
