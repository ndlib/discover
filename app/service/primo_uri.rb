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

  def base_basic_search_params
    @base_basic_search_params ||= base_params.merge({fn: 'search', mode: 'Basic'})
  end

  def base_advanced_search_params
    @base_advanced_search_params ||= base_params.merge({fn: 'search', mode: 'Advanced'})
  end

  def basic_search_params(value)
    base_basic_search_params.merge({ 'vl(freeText0)' => value})
  end

  def advanced_search_params(scope, value)
    base_advanced_search_params.merge({
      advanced_search_scope_name => advanced_search_scope_value(scope),
      "vl(1UIStartWith0)"=>"exact",
      'vl(freeText0)' => value
    })
  end

  def advanced_search_scope_name
    "vl(#{primo_configuration.advanced_search_scope_name})"
  end

  def advanced_search_scope_value(scope)
    scope
  end

  def basic_search(value)
    "#{base_path('search.do')}?#{basic_search_params(value).to_query}"
  end

  def advanced_search(scope, value)
    "#{base_path('search.do')}?#{advanced_search_params(scope, value).to_query}"
  end
end
