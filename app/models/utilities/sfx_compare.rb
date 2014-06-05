class Utilities::SfxCompare
  attr_reader :current_query, :current_params, :api_query, :api_params

  def initialize(current_query, api_query)
    @current_query = current_query
    @current_params = parse_qs_from_uri(current_query)

    @api_query = api_query
    @api_params = parse_qs_from_uri(api_query)
  end

  def all_keys
    current_params.keys + api_params.keys
  end


  def current_value(key)
    current_params[key].join(",")
  end


  def api_value(key)
    api_params[key].join(",")
  end


  def parse_qs_from_uri(uri)
    u = URI.parse(uri)
    CGI.parse(u.query)
  end


  def api_pre_checked?(key)
    (api_value(key).present?) ? 'checked=""' : ''
  end
end
