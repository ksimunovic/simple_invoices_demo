# frozen_string_literal: true

class ClientsController < ApplicationController
  def index
    return render json: [] if params[:name].strip.empty?

    @clients = Client.where('name ILIKE ?', "%#{params[:name]}%")
    render json: @clients.select(:id, :name)
  end
end
