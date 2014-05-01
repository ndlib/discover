class OnlineAccessController < ApplicationController
  def show
    @record = OnlineAccessDecorator.find(params[:id])
    respond_to do |format|
      format.html do
        if request.xhr?
          render layout: false
        else
          render
        end
      end
      format.json { render json: @record.object.to_json }
    end
  end
end
