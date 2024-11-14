class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def delete
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@invoice) }
      format.html { redirect_to invoices_path }
    end
  end
end
