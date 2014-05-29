class RecordsController < ApplicationController
  def show
    @record = RecordDecorator.find(params[:id])
    respond_to do |format|
      format.html do
        if request.xhr? || params[:xhr].present?
          render layout: false
        else
          render
        end
      end
      format.json { render json: @record.object.to_json }
    end
  end
end
