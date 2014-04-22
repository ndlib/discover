class HesburghErrors::ErrorsController < HesburghErrors::BaseController
  before_action :authenticate_user!
  before_action :check_authentication!

end
