class PrimoProxy < Draper::Decorator
  STRIP_PARAMS = ["action", "controller", "format", "path"]

  def page
    "#{original_params[:path]}.#{original_params[:format]}"
  end

  def params
    @params ||= original_params.reject{|k,v| STRIP_PARAMS.include?(k)}
  end

  def request
    object
  end

  def session
    request.session
  end

  def original_params
    request.params
  end

  def query_string
    fix_browse_query_string(request.query_string)
  end

  def fix_browse_query_string(string)
    if string =~ /fn=showBrowse/ && string =~ /fn=search/
      string.gsub(/&fn=search/,'')
    else
      string
    end
  end

  def request_parameters
    request.request_parameters
  end

  def vid
    params[:vid] || "NDU"
  end

  def tab
    params[:tab] || "nd_campus"
  end

  def host
    "primo-fe1.library.nd.edu"
  end

  def port
    1701
  end

  def host_with_port
    if port == 80
      host
    else
      "#{host}:#{port}"
    end
  end

  def base_url
    "http://#{host_with_port}"
  end

  def libweb_path(path_string = nil)
    "/primo_library/libweb/#{path_string}"
  end

  def libweb_url(path_string = nil)
    "#{base_url}#{libweb_path(path_string)}"
  end

  def format_page?
    (/action\/[^.]+\.do/ =~ page)
  end

  def page_path
    libweb_path(page)
  end

  def page_path_with_session
    if session[:jsessionid].present? && page_path =~ /[.]do$/
      "#{page_path};jsessionid=#{session[:jsessionid]}"
    else
      page_path
    end
  end

  def connection
    if @connection.nil?
      @connection = Faraday.new(url: base_url) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end
    @connection
  end

  def response
    if @response.nil?
      url = page_path_with_session+'?'+ query_string
      if request.post?
        @response ||= connection.post do |req|
          req.url url
          req.body = request_parameters.to_query
        end
      else
        @response ||= connection.get(url)
      end
      new_session_id = header_session_id(@response)
      if new_session_id
        session[:jsessionid] = new_session_id
      end
    end
    @response
  end

  def redirect?
    response.status == 302
  end

  def header_session_id(response_object)
    match = response_object.headers['set-cookie'].to_s.match(/JSESSIONID=([^;]+)/)
    if match
      match[1]
    else
      nil
    end
  end

  def page_includes_session?
    (page_path =~ /jsessionid/).present?
  end

  def parsed_location_header
    @parsed_location_header ||= URI.parse(response.headers['location'])
  end

  def redirect_path
    if parsed_location_header.host == host
      "#{parsed_location_header.path}?#{parsed_location_header.query}"
    else
      response.headers['location']
    end
  end

  def original_body
    @original_body ||= response.body
  end

  def body
    if format_page?
      PrimoProxyFormatter.format(self)
    else
      original_body
    end
  end
end
