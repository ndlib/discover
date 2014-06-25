class RecordsController < ApplicationController
  def show
    @tab = DetailsTab.new(self)
    respond_to do |format|
      format.html do
        if request.xhr? || params[:xhr].present?
          render layout: false
        else
          render
        end
      end
      format.json { render json: @tab.record.to_json }
    end
  end
end
