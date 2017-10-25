class ApplicationController < ActionController::Base
  before_filter :set_access_control_headers

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #include HesburghErrors::ControllerErrorTrapping

#  unless Rails.configuration.consider_all_requests_local
  #  setup_controller_errors
#  end


  def check_authentication!
    if !is_admin?
      raise ActionController::RoutingError.new('404')
    end
  end

  def is_admin?
    Permission.new(current_user).is_admin?
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = "*"
  end
end
