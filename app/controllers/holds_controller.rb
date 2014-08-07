class HoldsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:place_request]

  def hold_request
    @record = HoldsTab.new(self)

    respond_with('request')
  end

  def place_request
    params[:pickup_location] += '1'
    request = HoldsRequest.new(params)
    response = request.place_hold
    respond_to do |format|
      format.any { render json: response.body.to_json, status: response.status, content_type: "application/json" }
    end
  end


  def respond_with(template)
    respond_to do |format|
      format.html do
        if request.xhr? || params[:xhr].present?
          render template, layout: false
        else
          render template
        end
      end
      format.json { render json: @record.record.to_json }
    end
  end
end
