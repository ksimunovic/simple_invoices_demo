# frozen_string_literal: true

# Shift around data to use clients entity instead of client_name
class MoveClientNameToClientId < ActiveRecord::Migration[7.2]
  def up
    # Add the client reference with null: true
    add_reference :invoices, :client, null: true, foreign_key: true

    # Populate client_id using client_name
    Invoice.reset_column_information
    Invoice.find_each do |invoice|
      client = Client.find_or_create_by(name: invoice.client_name)
      invoice.update(client_id: client.id)
    end

    # Remove client_name after populating
    remove_column :invoices, :client_name

    # Change client_id to not allow null
    change_column_null :invoices, :client_id, false
  end

  def down
    # Re-add client_name and remove client_id
    add_column :invoices, :client_name, :string
    Invoice.reset_column_information
    Invoice.find_each do |invoice|
      invoice.update(client_name: invoice.client.name)
    end

    remove_reference :invoices, :client, foreign_key: true
  end
end
