class PrimoMissingFieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_authentication!


  def index
    @primo_keys = PrimoDisplayFieldDecorator.decorate_collection(PrimoDisplayField.all.order(:key))
  end


  def show
    object = PrimoDisplayField.find(params[:id])
    @primo_missing_field = PrimoDisplayFieldDecorator.decorate(object)
  end


end
