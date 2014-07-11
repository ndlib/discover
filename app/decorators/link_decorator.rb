class LinkDecorator < Draper::Decorator

  def link
    h.link_to title, url, target: '_blank'
  end


  def notes
    if object['notes'].present?
      h.content_tag(:ul) do
        object['notes'].collect { | item | h.concat(h.content_tag(:li, h.raw(item))) }
      end
    else
      ""
    end
  end


  def title
    object['title']
  end

  def url
    object['url']
  end

  def source
    object['source']
  end

  def service_type
    object['service_type']
  end

end
