# frozen_string_literal: true

class ClientsController < ApplicationController
  def index
    @clients = Client.where('name ILIKE ?', "%#{params[:name]}%")
    render json: @clients.select(:id, :name)
  end
end
