class UtilitiesController  < ApplicationController
  before_action :authenticate_user!
  before_action :check_authentication!


  def sfx_compare

    if params[:search]
      @sfx_compare = Utilities::SfxCompare.new(params[:current_query], params[:api_query])
    end

  end

end
