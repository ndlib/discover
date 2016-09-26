class ExamplesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_authentication!

  def index
    @example_collection = ExampleRecordCollection.new(params[:institution])
  end
end
