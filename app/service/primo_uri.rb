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

  def host
    primo_configuration.host
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

  def advanced_search_params(scope, value, placement = '0')
    base_advanced_search_params.merge({
      advanced_search_scope_name(placement) => advanced_search_scope_value(scope),
      "vl(1UIStartWith#{placement})"=>"exact",
      "vl(freeText#{placement})" => value
    })
  end

  def advanced_search_scope_name(placement)
    "vl(#{primo_configuration.advanced_search_scope_name(placement)})"
  end

  def advanced_search_scope_value(scope)
    TranslateAdvancedSearchScope.call(scope)
  end

  def basic_search(value)
    "#{base_path('search.do')}?#{basic_search_params(value).to_query}"
  end

  def advanced_search(scope1, value1, scope2 = false, value2 = false)
    "#{base_path('search.do')}?#{advanced_search_params(scope1, value1, '0').to_query}&#{value2 ? advanced_search_params(scope2, value2, '1').to_query : ''}"
  end

  def display_params(record_id, selected_tab = nil)
    selected_tab ||= 'detailsTab'
    base_params.merge({ doc: record_id, fn: 'search', ct: 'display', displayMode: 'full', tabs: selected_tab})
  end

  def display_no_base_path(record_id, selected_tab = nil)
    "display.do?#{display_params(record_id, selected_tab).to_query}"
  end

  def signin_params(targetURL)
    base_params.merge({targetURL: targetURL, loginFn: 'signin'})
  end

  def signin(targetURL)
    "#{base_path('login.do')}?#{signin_params(targetURL).to_query}"
  end

  def request_tab_signin(record_id)
    target = display_no_base_path(record_id, 'requestTab')
    signin(target)
  end
end
