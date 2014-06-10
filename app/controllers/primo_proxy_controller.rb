class PrimoProxyController < ApplicationController

  def index
    @proxy = PrimoProxy.new(params)
    render text: @proxy.body
  end
end
