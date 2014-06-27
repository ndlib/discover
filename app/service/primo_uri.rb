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

  def basic_search_params
    @basic_search_params ||= base_params.merge({fn: 'search', mode: 'Basic'})
  end

  def advanced_search_params
    @advanced_search_params ||= base_params.merge({fn: 'search', mode: 'Advanced'})
  end

  def basic_search(value)
    params = basic_search_params.merge({ 'vl(freeText0)' => value})
    "#{base_path('search.do')}?#{params.to_query}"
  end

  def advanced_search(scope, value)
    params = advanced_search_params.merge({ 'vl(freeText0)' => value})
    "#{base_path('search.do')}?#{params.to_query}"
  end
end
