class PrimoDemoDecorator < Draper::Decorator
  delegate :search_term, to: :object

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

  def primo_path(path_string = nil)
    "/primo_library/libweb/#{path_string}"
  end

  def libweb_url(path_string = nil)
    "#{base_url}#{primo_path(path_string)}"
  end

  def search_url
    libweb_url("/action/search.do")
  end

  def connection
    if @connection.nil?
      @connection = Faraday.new()
    end
    @connection
  end

  def params
    {
      "mode" => "Basic",
      "vid" => vid,
      "fn" => "search",
      "tab" => tab
    }.merge(object.params)
  end

  def search
    @search ||= connection.get(search_url, params)
  end

  def demo_path
    h.demo_path(:index)
  end

  def body
    if @body.nil?
      @body = original_body
      @body = fix_primo_links(@body)
      @body = set_local_css(@body)
      @body = fix_form(@body)
      @body = rename_reviews_tab(@body)
      # @body = disable_pds(@body)
    end
    @body
  end

  def fix_primo_links(text)
    text = text.gsub("href=\"../", "href=\"#{libweb_url}/")
    text = text.gsub("src=\"../", "src=\"#{libweb_url}/")
    text
  end

  def set_local_css(text)
    local_css = h.stylesheet_link_tag("primo/ndu/index", media: "all")
    local_css += h.stylesheet_link_tag("demo", media: "all")
    text = text.gsub(/<link[^>]+discover.library.nd.edu[^>]+>/, local_css)
    text
  end

  def fix_form(text)
    text.gsub(/action="\/primo_library\/libweb\/action\/search.do[^"]+"/,"action=\"#{demo_path}\"")
  end

  def rename_reviews_tab(text)
    text.gsub("class=\"EXLReviewsTab", "class=\"EXLOldReviewsTab")
  end

  def disable_pds(text)
    text.gsub('exlIdssologinRequest','')
  end

  def original_body
    @original_body ||= search.body
  end
end
