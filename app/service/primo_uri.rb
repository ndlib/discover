class PrimoURI
  attr_reader :vid, :tab

  def initialize(vid, tab)
    @vid = vid
    if tab.present?
      @tab = tab
    else
      @tab = nil
    end
  end

  def base_path(action = nil)
    "/primo_library/libweb/action/#{action}"
  end

  def base_params
    if @base_params.nil?
      @base_params = HashWithIndifferentAccess.new
      @base_params[:vid] = vid
      if tab.present?
        @base_params[:tab] = tab
      end
    end
    @base_params
  end

  def base_search_params
    base_params.merge({fn: 'search', mode: 'Basic'})
  end

  def search_path
    "#{base_path('search.do')}?#{base_search_params.to_query}"
  end
end
