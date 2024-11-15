# frozen_string_literal: true

# Controller for handling invoice resource
class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.order(created_at: :desc).all
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('invoice_form', partial: 'invoices/form',
                                                 locals: { invoice: Invoice.new }),
            turbo_stream.prepend('invoices', partial: 'invoices/invoice',
                                             locals: { invoice: @invoice })
          ]
        end
        format.html { redirect_to invoices_path }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('invoice_form',
                                                    partial: 'invoices/form',
                                                    locals: { invoice: @invoice })
        end
      end
    end
  end

  def edit
    @invoice = find_invoice
    return handle_not_found if @invoice.nil?

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('invoice_form', partial: 'invoices/form',
                                                                  locals: { invoice: @invoice })
      end
    end
  end

  def update
    @invoice = find_invoice
    return handle_not_found if @invoice.nil?

    if @invoice.update(invoice_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('invoice_form', partial: 'invoices/form',
                                                 locals: { invoice: Invoice.new }),
            turbo_stream.replace("invoice_#{@invoice.id}", partial: 'invoices/invoice',
                                                           locals: { invoice: @invoice })
          ]
        end
        format.html { redirect_to invoices_path }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('invoice_form', partial: 'invoices/form',
                                                                    locals: { invoice: @invoice })
        end
      end
    end
  end

  def delete
    @invoice = find_invoice
    return handle_not_found if @invoice.nil?

    @invoice.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@invoice) }
      format.html { redirect_to invoices_path }
    end
  end

  private

  def find_invoice
    Invoice.find_by(id: params[:id])
  end

  def handle_not_found
    flash[:error] = 'Invoice not found'
    redirect_to root_path
  end

  def invoice_params
    params.require(:invoice).permit(:client_name, :amount, :tax)
  end
end
