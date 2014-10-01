class RedirectController < ApplicationController

  def redirect
    params.require(:pid, :source, :title, :u)

    StatsLinkClicks.record_click(params[:pid], params[:source], params[:title])
    redirect_to params[:u]
  end

end
