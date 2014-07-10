class HoldsController < ApplicationController

  def volumns
    action = HoldsAction.initialize(self)

    @record = action.record

    respond_to do |format|
      format.html do
        if request.xhr? || params[:xhr].present?
          render 'step1', layout: false
        else
          render 'step1'
        end
      end
      format.json { render json: @record.object.to_json }
    end
  end


  def institutions

    action = HoldsAction.initialize(self)

    @record = action.record

    respond_to do |format|
      format.html do
        if request.xhr? || params[:xhr].present?
          render 'step2', layout: false
        else
          render 'step2'
        end
      end
      format.json { render json: @record.object.to_json }
    end
  end


  def pickup

    action = HoldsAction.initialize(self)

    @record = action.record

    respond_to do |format|
      format.html do
        if request.xhr? || params[:xhr].present?
          render 'step3', layout: false
        else
          render 'step3'
        end
      end
      format.json { render json: @record.object.to_json }
    end
  end


  def finalize

    action = HoldsAction.initialize(self)

    @record = action.record

    respond_to do |format|
      format.html do
        if request.xhr? || params[:xhr].present?
          render 'step4', layout: false
        else
          render 'step4'
        end
      end
      format.json { render json: @record.object.to_json }
    end
  end


  def submit
    action = HoldsAction.initialize(self)

    @record = action.record

    respond_to do |format|
      format.html do
        if request.xhr? || params[:xhr].present?
          render 'submit_complete', layout: false
        else
          render 'submit_complete'
        end
      end
      format.json { render json: @record.object.to_json }
    end

  end
end
