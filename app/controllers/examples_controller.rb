class ExamplesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_authentication!


  def index
    @examples = ExampleRecordDecorator.by_institution(params[:institution])
  end
end
