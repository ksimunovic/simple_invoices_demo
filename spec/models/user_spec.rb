# frozen_string_literal: true

# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = described_class.new(email: 'test@example.com', password: 'password')
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user = described_class.new(email: nil, password: 'password')
    expect(user).not_to be_valid
  end

  it 'is not valid without a password' do
    user = described_class.new(email: 'test@example.com', password: nil)
    expect(user).not_to be_valid
  end

  it 'is valid with a unique email' do
    described_class.create(email: 'test@example.com', password: 'password')
    user = described_class.new(email: 'test@example.com', password: 'password')
    expect(user).not_to be_valid
  end
end
