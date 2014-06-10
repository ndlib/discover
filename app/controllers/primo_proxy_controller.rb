class PrimoProxyController < ApplicationController
  protect_from_forgery except: :index

  def index
    @proxy = PrimoProxy.new(params)
    render text: @proxy.body
  end
end
