class LinkDecorator < Draper::Decorator

  def link
    h.link_to title, url, target: '_blank'
  end


  def notes
    if get('notes').present?
      h.content_tag(:ul) do
        get('notes').collect { | item | h.concat(h.content_tag(:li, h.raw(item))) }
      end
    else
      ""
    end
  end


  def title
    get('title')
  end

  def url
    get('url')
  end

  def source
    get('source')
  end

  def service_type
    get('service_type')
  end

  private

    def get(key)
      object[key]
    end

end
