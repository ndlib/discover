class DemoController < ApplicationController
  layout 'primo'

  def catcher

  end

  def index
    require 'open-uri'

    @demo = PrimoDemo.new(params)
    render text: @demo.body
  end
end
