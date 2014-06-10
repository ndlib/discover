class PrimoProxySearch < Draper::Decorator
  delegate :original_body, :libweb_url, to: :object

  def body
    if @body.nil?
      @body = original_body
      @body = fix_primo_links(@body)
      @body = set_local_css(@body)
      # @body = fix_form(@body)
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
