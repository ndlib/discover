class HoldsController < ApplicationController


  def hold_request
    @record = HoldsTab.new(self)

    respond_with('request')
  end

  def place_request
    @record = HoldsTab.new(self)
    render text: ''
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
      format.json { render json: @record.object.to_json }
    end
  end
end
