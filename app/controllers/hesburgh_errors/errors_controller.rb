class HesburghErrors::ErrorsController < HesburghErrors::BaseController
  before_action :authenticate_user!
  before_action :check_authentication!

  protected

    def check_authentication!
      if !['jhartzle', 'jkennel', 'rfox2', 'rmalott', 'lthiel'].include?(current_user.username)
        raise ActionController::RoutingError.new('404')
      end
    end
end
