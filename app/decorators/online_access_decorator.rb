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
      :fulltext_links
    ]
  end

  def link_fields
    object.link_fields
  end


  def fulltext_links
    ulize_array(object.fulltext_links)
  end



  private

    def ulize_array(arr)
      if arr.present?
        h.content_tag(:ul) do
          arr.collect { | item | h.concat(h.content_tag(:li, item)) }
        end
      end
    end
end
