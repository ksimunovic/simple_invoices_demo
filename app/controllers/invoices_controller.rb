# frozen_string_literal: true

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
            turbo_stream.replace("invoice_#{@invoice.id}", partial: 'invoices/invoice',
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
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('invoice_form',
                                                  partial: 'invoices/form',
                                                  locals: { invoice: @invoice })
      end
    end
  end

  def update
    @invoice = Invoice.find(params[:id])
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
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@invoice) }
      format.html { redirect_to invoices_path }
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:client_name, :amount, :tax)
  end
end
