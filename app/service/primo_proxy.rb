class PrimoProxy < Draper::Decorator
  STRIP_PARAMS = ["action", "controller", "format", "path"]

  def page
    "#{original_params[:path]}.#{original_params[:format]}"
  end

  def params
    @params ||= original_params.reject{|k,v| STRIP_PARAMS.include?(k)}
  end

  def original_params
    object
  end

  def vid
    "NDU"
  end

  def tab
    "nd_campus"
  end

  def host
    "primo-fe1.library.nd.edu:1701"
  end

  def base_url
    "http://#{host}"
  end

  def libweb_path(path_string = nil)
    "/primo_library/libweb/#{path_string}"
  end

  def libweb_url(path_string = nil)
    "#{base_url}#{libweb_path(path_string)}"
  end

  def search_page?
    (/search\.do/ =~ page)
  end

  def page_path
    libweb_path(page)
  end

  def connection
    if @connection.nil?
      @connection = Faraday.new(url: base_url)
    end
    @connection
  end

  def get
    @get ||= connection.get(page_path, params)
  end

  def original_body
    @original_body ||= get.body
  end

  def body
    if search_page?
      PrimoProxySearch.format(self)
    else
      original_body
    end
  end
end
