# frozen_string_literal: true

# Default App Controller
class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from StandardError, with: :handle_exception

  private

  def handle_exception(exception)
    flash[:error] = "An error occurred: #{exception.message}"
    redirect_to root_path and return unless performed?
  end
end
