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

  def body
    if @body.nil?
      @body = original_body.gsub("href=\"../", "href=\"#{base_url}/")
      @body.gsub!("src=\"../", "src=\"#{base_url}/")
    end
    @body
  end

  def original_body
    @original_body ||= open_url.read
  end
end
