class HesburghErrors::ErrorsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_authentication!

end
