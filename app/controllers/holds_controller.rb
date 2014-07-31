class HoldsController < ApplicationController


  def volumes
    @record = HoldsTab.new(self)

    respond_with('step1')
  end


  def institutions
    @record = HoldsTab.new(self)
    @record.save_input(params)

    respond_with('step2')
  end


  def pickup
    @record = HoldsTab.new(self)
    @record.save_input(params)

    respond_with('step3')
  end


  def finalize
    @record = HoldsTab.new(self)
    @record.save_input(params)

    respond_with('step4')
  end


  def submit
    @record = HoldsTab.new(self)
    @record.save_input(params)

    respond_with('submit_complete')
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
