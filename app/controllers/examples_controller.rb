class ExamplesController < ApplicationController
  def index
    @examples = ExampleRecordDecorator.all
  end
end
