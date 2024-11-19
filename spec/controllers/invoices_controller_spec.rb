# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvoicesController, type: :controller do
  let(:valid_attributes) { attributes_for(:invoice, client_id: create(:client).id) }
  let!(:invoice) { create(:invoice) }

  describe "GET #index" do
    it "assigns @invoices" do
      sign_in create(:user)
      get :index
      expect(assigns(:invoices)).to eq([invoice])
    end
  end

  describe "GET #new" do
    it "assigns a new invoice when authenticated" do
      sign_in create(:user)
      get :new, format: :turbo_stream
      expect(assigns(:invoice)).to be_a_new(Invoice)
    end

    it "redirects if not authenticated" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Invoice if authenticated" do
        sign_in create(:user)
        expect do
          post :create, params: {invoice: valid_attributes}, format: :turbo_stream
        end.to change(Invoice, :count).by(1)
      end

      it "renders turbo stream for new invoice" do
        sign_in create(:user)
        post :create, params: {invoice: valid_attributes}, format: :turbo_stream
        expect(response).to render_template(partial: "invoices/_invoice")
      end
    end

    context "with invalid params" do
      it "does not create an invoice without client info" do
        sign_in create(:user)
        expect do
          post :create, params: {invoice: {client_name: nil}}, format: :turbo_stream
        end.not_to change(Invoice, :count)
      end

      it "redirects if client info is missing" do
        sign_in create(:user)
        post :create, params: {invoice: {client_name: nil}}, format: :turbo_stream
        expect(flash[:error]).to be_present
        expect(response).to redirect_to(root_path)
      end

      it "redirects if not authenticated" do
        post :create, params: {invoice: valid_attributes}, format: :turbo_stream
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested invoice when authenticated" do
      sign_in create(:user)
      get :edit, params: {id: invoice.id}, format: :turbo_stream
      expect(assigns(:invoice)).to eq(invoice)
    end

    it "redirects if invoice not found" do
      sign_in create(:user)
      get :edit, params: {id: 0}, format: :turbo_stream
      expect(flash[:error]).to eq("Invoice not found")
      expect(response).to redirect_to(root_path)
    end

    it "redirects if not authenticated" do
      get :edit, params: {id: invoice.id}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates the requested invoice if authenticated" do
        sign_in create(:user)
        patch :update, params: {id: invoice.id, invoice: {amount: 150}}, format: :turbo_stream
        invoice.reload
        expect(invoice.amount).to eq(150)
      end

      it "renders turbo stream for updated invoice" do
        sign_in create(:user)
        patch :update, params: {id: invoice.id, invoice: {amount: 150}}, format: :turbo_stream
        expect(response).to render_template(partial: "invoices/_invoice")
      end
    end

    context "with deleted invoice" do
      before { invoice.destroy }

      it "does not update the invoice" do
        sign_in create(:user)
        patch :update, params: {id: invoice.id, invoice: {client_name: nil}}
        expect(invoice.reload.client.name).not_to be_nil
      end

      it "redirects if invoice not found" do
        sign_in create(:user)
        patch :update, params: {id: 0}
        expect(flash[:error]).to eq("Invoice not found")
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "does not update the invoice" do
        sign_in create(:user)
        patch :update, params: {id: invoice.id, invoice: {client_name: nil}}, format: :turbo_stream
        expect(invoice.reload.client.name).not_to be_nil
      end

      it "renders the invoice form" do
        sign_in create(:user)
        patch :update, params: {id: invoice.id, invoice: {client_name: nil}}, format: :turbo_stream
        expect(response).to render_template(partial: "invoices/_form")
      end

      it "redirects if not authenticated" do
        patch :update, params: {id: invoice.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #delete" do
    it "destroys the requested invoice if authenticated" do
      sign_in create(:user)
      expect do
        delete :delete, params: {id: invoice.id}, format: :turbo_stream
      end.to change(Invoice, :count).by(-1)
    end

    it "redirects if invoice not found" do
      sign_in create(:user)
      delete :delete, params: {id: 0}
      expect(flash[:error]).to eq("Invoice not found")
      expect(response).to redirect_to(root_path)
    end

    it "redirects if not authenticated" do
      delete :delete, params: {id: invoice.id}
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
