# frozen_string_literal: true

# spec/controllers/invoices_controller_spec.rb
require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  let(:valid_attributes) { { client_name: 'John Doe', amount: 100, tax: 10 } }
  let(:invoice) { Invoice.create!(valid_attributes) }

  describe 'GET #index' do
    it 'assigns @invoices' do
      get :index
      expect(assigns(:invoices)).to eq([invoice])
    end
  end

  describe 'GET #new' do
    it 'assigns a new invoice' do
      get :new
      expect(assigns(:invoice)).to be_a_new(Invoice)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Invoice' do
        expect do
          post :create, params: { invoice: valid_attributes }
        end.to change(Invoice, :count).by(1)
      end

      it 'redirects to invoices path' do
        post :create, params: { invoice: valid_attributes }
        expect(response).to redirect_to(invoices_path)
      end
    end

    context 'with invalid params' do
      it 'does not create an invoice' do
        expect do
          post :create, params: { invoice: { client_name: nil } }
        end.not_to change(Invoice, :count)
      end

      it 'renders the invoice form' do
        post :create, params: { invoice: { client_name: nil } }, format: :turbo_stream
        expect(response).to render_template(partial: 'invoices/_form')
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested invoice' do
      get :edit, params: { id: invoice.id }
      expect(assigns(:invoice)).to eq(invoice)
    end

    it 'redirects if invoice not found' do
      get :edit, params: { id: 0 }
      expect(flash[:error]).to eq('Invoice not found')
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the requested invoice' do
        patch :update, params: { id: invoice.id, invoice: { amount: 150 } }
        invoice.reload
        expect(invoice.amount).to eq(150)
      end

      it 'redirects to invoices path' do
        patch :update, params: { id: invoice.id, invoice: { amount: 150 } }
        expect(response).to redirect_to(invoices_path)
      end
    end

    context 'with deleted invoice' do
      before { invoice.destroy }

      it 'does not update the invoice' do
        patch :update, params: { id: invoice.id, invoice: { client_name: nil } }
        expect(invoice.reload.client_name).not_to be_nil
      end

      it 'redirects if invoice not found' do
        delete :delete, params: { id: 0 }
        expect(flash[:error]).to eq('Invoice not found')
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it 'does not update the invoice' do
        patch :update, params: { id: invoice.id, invoice: { client_name: nil } }
        expect(invoice.reload.client_name).not_to be_nil
      end

      it 'renders the invoice form' do
        patch :update, params: { id: invoice.id, invoice: { client_name: nil } }, format: :turbo_stream
        expect(response).to render_template(partial: 'invoices/_form')
      end
    end
  end

  describe 'DELETE #delete' do
    it 'destroys the requested invoice' do
      invoice
      expect do
        delete :delete, params: { id: invoice.id }
      end.to change(Invoice, :count).by(-1)
    end

    it 'redirects to invoices path' do
      delete :delete, params: { id: invoice.id }
      expect(response).to redirect_to(invoices_path)
    end

    it 'redirects if invoice not found' do
      delete :delete, params: { id: 0 }
      expect(flash[:error]).to eq('Invoice not found')
      expect(response).to redirect_to(root_path)
    end
  end
end
