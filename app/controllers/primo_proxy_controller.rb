class PrimoProxyController < ApplicationController
  protect_from_forgery except: :index

  def index
    @proxy = PrimoProxy.new(request)
    if @proxy.redirect?
      redirect_to @proxy.redirect_path
    else
      render text: @proxy.body
    end
  end
end
