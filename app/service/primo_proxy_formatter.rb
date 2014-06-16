class PrimoProxyFormatter < Draper::Decorator
  delegate :original_body, :libweb_url, to: :object

  def body
    if @body.nil?
      @body = original_body
      @body = fix_primo_links(@body)
      @body = set_local_css(@body)
      @body = set_local_js(@body)
      @body = rename_reviews_tab(@body)
      # @body = disable_sso(@body)
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
    local_css += h.stylesheet_link_tag("proxy", media: "all")
    text.gsub(/<link[^>]+discover.library.nd.edu[^>]+>/, local_css)
  end

  def set_local_js(text)
    local_js = h.javascript_include_tag("primo/ndu/index")
    local_js += h.javascript_include_tag("proxy")
    text.gsub(/<script[^>]+discover.library.nd.edu[^>]+><\/script>/, local_js)
  end

  def rename_reviews_tab(text)
    text.gsub("class=\"EXLReviewsTab", "class=\"EXLOldReviewsTab")
  end

  def disable_sso(text)
    text.gsub('exlIdssologinRequest','')
  end

  def original_body
    @original_body ||= object.original_body
  end

  def self.format(body)
    decorator = new(body)
    decorator.body
  end
end
