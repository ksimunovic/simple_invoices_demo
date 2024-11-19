# frozen_string_literal: true

# Controller for handling invoice resource
class InvoicesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_invoice, only: [:edit, :update, :delete]

  def index
    @invoices = Invoice.includes(:client).order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @invoice = Invoice.new
  end

  def create
    result = Invoice.create_with_client(invoice_params)

    if result[:success]
      render_invoice_response("invoice_form", Invoice.new, result[:invoice])
    else
      flash[:error] = result[:message]
      redirect_to root_path
    end
  end

  def edit
    render_invoice_response("invoice_form", @invoice)
  end

  def update
    if @invoice.update(invoice_params.except(:client_name))
      render_invoice_response("invoice_form", Invoice.new, @invoice)
    else
      render_invoice_response("invoice_form", @invoice)
    end
  end

  def delete
    @invoice.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@invoice) }
    end
  end

  private

  def set_invoice
    @invoice = Invoice.find_by(id: params[:id]) || handle_not_found
  end

  def find_or_create_client
    return Client.find_by(id: invoice_params[:client_id]) if invoice_params[:client_id].present?

    Client.find_or_create_by(name: invoice_params[:client_name])
  end

  def render_invoice_response(form_id, new_invoice, invoice = nil)
    respond_to do |format|
      format.turbo_stream do
        streams = [
          turbo_stream.replace(form_id, partial: "invoices/form", locals: {invoice: new_invoice})
        ]

        streams << turbo_stream.prepend("invoices", partial: "invoices/invoice", locals: {invoice: invoice}) if invoice

        render turbo_stream: streams
      end
    end
  end

  def handle_not_found
    flash[:error] = "Invoice not found"
    redirect_to root_path
  end

  def invoice_params
    params.require(:invoice).permit(:client_id, :amount, :tax, :client_name)
  end
end
