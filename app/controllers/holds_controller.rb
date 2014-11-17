class HoldsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:place_request]

  def hold_request
    @record = HoldsTab.new(self)

    respond_with('request')
  end

  def place_request
    request = HoldsRequest.new(params)
    response = request.place_hold
    respond_to do |format|
      format.any { render json: response.to_json, status: request_status_code(response['status']), content_type: "application/json" }
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

  private

  def request_status_code(status)
    if status == "Success"
      200
    else
      500
    end
  end
end
