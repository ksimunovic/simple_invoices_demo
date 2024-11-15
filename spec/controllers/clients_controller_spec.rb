# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  describe 'GET #index' do
    let!(:client) { Client.create(name: 'John Doe') }

    context 'when user is authenticated' do
      before { sign_in create(:user) }

      it 'returns clients matching the name' do
        get :index, params: { name: 'John' }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq([{ 'id' => client.id, 'name' => client.name }])
      end

      it 'returns an empty array if name is blank' do
        get :index, params: { name: '' }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq([])
      end
    end

    context 'when user is not authenticated' do
      it 'allows access to index' do
        get :index, params: { name: 'John' }
        expect(response).to have_http_status(:success)
      end
    end
  end
end
