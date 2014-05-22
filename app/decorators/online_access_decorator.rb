require 'uri/http'

class OnlineAccessDecorator < Draper::Decorator

  def self.find(id)
    record = DiscoveryQuery.find_by_id(id)
    self.new(record)
  end

  def title
    object.title
  end


  def detail_content
    if @detail_content.nil?
      @detail_content = []
      detail_methods.each do |method|
        method_content = self.send(method)
        if method_content.present?
          @detail_content << [method, method_content]
        end
      end
    end
    @detail_content
  end


  def detail_methods
    [
      :fulltext_links,
      :table_of_contents_links
    ]
  end

  def link_fields
    object.link_fields
  end


  def fulltext_links
    ulize_array(object.fulltext_links)
  end


  def table_of_contents_links
    ulize_array(object.table_of_contents_links)
  end




  private

    def ulize_array(arr)
      if arr.present?
        h.content_tag(:ul) do
          arr.collect { | item | h.concat(h.content_tag(:li, link_to_src(item))) }
        end
      end
    end


    def link_to_src(item)
      h.link_to(h.t("online_access.#{item[:title]}", url: get_domain_name(item[:url])), item[:url], target: 'blank')
    end


    def get_domain_name(url)
      return if url.nil?

      uri = URI.parse(url)
      if uri.present?
        uri.host.gsub('www.', '')
      else
        nil
      end
    end
end
