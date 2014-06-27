class PrimoURI
  attr_reader :primo_configuration, :current_tab

  def initialize(primo_configuration, current_tab = nil)
    @primo_configuration = primo_configuration
    if current_tab.present?
      @current_tab = current_tab
    else
      @current_tab = primo_configuration.default_tab
    end
  end

  def vid
    primo_configuration.vid
  end

  def base_path(action = nil)
    path = "/primo_library/libweb/action"
    if action.present?
      path += "/#{action}"
    end
    path
  end

  def base_params
    if @base_params.nil?
      @base_params = HashWithIndifferentAccess.new
      @base_params[:vid] = vid
      if current_tab.present?
        @base_params[:tab] = current_tab
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
