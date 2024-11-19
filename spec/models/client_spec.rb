# frozen_string_literal: true

# spec/models/client_spec.rb
require "rails_helper"

RSpec.describe Client, type: :model do
  let(:valid_attributes) { {name: "John Doe"} }
  let(:client) { described_class.new(valid_attributes) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(client).to be_valid
    end

    it "is invalid without a name" do
      client.name = nil
      expect(client).not_to be_valid
    end

    it "is invalid with a duplicate name" do
      described_class.create!(valid_attributes)
      duplicate_client = described_class.new(valid_attributes)
      expect(duplicate_client).not_to be_valid
    end

    it "is valid with a duplicate name if previous record is deleted" do
      described_class.create!(valid_attributes).destroy # Soft delete the client
      duplicate_client = described_class.new(valid_attributes)
      expect(duplicate_client).to be_valid
    end
  end

  describe "associations" do
    it "has many invoices" do
      expect(client).to respond_to(:invoices)
    end
  end
end
