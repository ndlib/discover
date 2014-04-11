class RecordsController < ApplicationController
  def show
    respond_to do |format|
      format.html do
        if request.xhr?
          render layout: false
        else
          render
        end
      end
    end
  end
end
