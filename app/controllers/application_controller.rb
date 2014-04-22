class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include HesburghErrors::ControllerErrorTrapping

  unless Rails.configuration.consider_all_requests_local
    setup_controller_errors
  end
end
