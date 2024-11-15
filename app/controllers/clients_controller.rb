# frozen_string_literal: true

# Enables searching of existing clients
class ClientsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    return render json: [] if params[:name].strip.empty?

    @clients = Client.where('name ILIKE ?', "%#{params[:name]}%")
    render json: @clients.select(:id, :name)
  end
end
