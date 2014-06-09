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
    "http://#{host}/primo_library/libweb"
  end

  def url
    "#{base_url}/action/search.do?mode=Basic&vid=#{vid}&vl(freeText0)=#{search_term}&fn=search&tab=#{tab}"
  end

  def open_url
    if @open.nil?
      require 'open-uri'
      @open = open(url)
    end
    @open
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
    end
    @body
  end

  def fix_primo_links(text)
    text = text.gsub("href=\"../", "href=\"#{base_url}/")
    text = text.gsub("src=\"../", "src=\"#{base_url}/")
    text
  end

  def set_local_css(text)
    local_css = h.stylesheet_link_tag("primo/ndu/index", media: "all")
    text = text.gsub(/<link[^>]+discover.library.nd.edu[^>]+>/, local_css)
    text
  end

  def fix_form(text)
    text = text.gsub(/action="\/primo_library\/libweb\/action\/search.do[^"]+"/,"action=\"#{demo_path}\"")
  end

  def original_body
    @original_body ||= open_url.read
  end
end
