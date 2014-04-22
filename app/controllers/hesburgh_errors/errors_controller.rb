class HesburghErrors::ErrorsController < HesburghErrors::BaseController
  before_action :check_authentication

  protected

    def check_authentication
      raise "To use the errors controller you must implement authentication!!!!!!!"
    end
end
